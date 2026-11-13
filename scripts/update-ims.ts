import { createHash } from "node:crypto";
import { readFile, writeFile } from "node:fs/promises";
import { resolve } from "node:path";

const repository = "wyattjoh/ims";
const latestURL = `https://api.github.com/repos/${repository}/releases/latest`;
const downloadRoot = `https://github.com/${repository}/releases/download/`;
const maximumAssetSize = 128 * 1024 * 1024;

type Loader = (url: string) => Promise<Uint8Array>;
type Update = { content: string | undefined; message: string };

function versionFrom(cask: string): string {
  const versions = [...cask.matchAll(/^\s*version "(\d+\.\d+\.\d+)"\s*$/gm)];
  if (versions.length !== 1) throw new Error("Expected one stable cask version");
  return versions[0][1];
}

function compareVersions(left: string, right: string): number {
  const a = left.split(".").map(BigInt);
  const b = right.split(".").map(BigInt);
  for (let i = 0; i < 3; i++) {
    if (a[i] !== b[i]) return a[i] > b[i] ? 1 : -1;
  }
  return 0;
}

function inspectCask(cask: string) {
  const version = versionFrom(cask);
  const archives = new Map<string, string>();
  const normalized = cask
    // GoReleaser replaced its historical comment with this declarative stanza.
    .replace(/^\s*# No zap stanza required\s*$/gm, "zap :not_required")
    .split("\n")
    .map((line) => line.trim())
    .filter((line) => line !== "")
    .join("\n");
  const structure = normalized
    .replace(/^version "\d+\.\d+\.\d+"$/gm, 'version "VERSION"')
    .replace(
      /^on_(macos|linux) do\n((?:on_(?:intel|arm) do\nsha256 "[a-f0-9]{64}"\nurl "[^"\n]+"\nend\n){2})end$/gm,
      (_block, os: string, body: string) => {
        for (const match of body.matchAll(
          /^on_(intel|arm) do\nsha256 "([a-f0-9]{64})"\nurl "([^"\n]+)"\nend$/gm,
        )) {
          const platform = `${os === "macos" ? "darwin" : "linux"}_${match[1] === "intel" ? "amd64" : "arm64"}`;
          const archive = `ims_v${version}_${platform}.tar.gz`;
          const expectedURL = `${downloadRoot}v${version}/${archive}`;
          if (match[3].replaceAll("#{version}", version) !== expectedURL) {
            throw new Error(`Unexpected cask archive URL: ${match[3]}`);
          }
          if (archives.has(archive)) throw new Error(`Duplicate cask platform: ${platform}`);
          archives.set(archive, match[2]);
        }
        // Each recognized platform block was fully parsed and its URLs checked.
        // Preserve all other Ruby verbatim for comparison with the trusted cask.
        return "PLATFORM";
      },
    );
  if (archives.size !== 4) throw new Error("Cask structure changed: expected four platforms");
  return { structure, archives };
}

function checksum(bytes: Uint8Array): string {
  return createHash("sha256").update(bytes).digest("hex");
}

function text(bytes: Uint8Array): string {
  if (bytes.length > 1024 * 1024) throw new Error("Metadata asset exceeds 1 MiB");
  return new TextDecoder("utf-8", { fatal: true }).decode(bytes);
}

/**
 * Prepare a verified cask update from a public IMS release without executing Ruby.
 * The loader is injected so tests require neither credentials nor network access.
 * Incomplete releases and unchanged versions leave the tap untouched.
 */
export async function prepareUpdate(current: string, load: Loader): Promise<Update> {
  const release = JSON.parse(text(await load(latestURL)));
  if (
    typeof release.tag_name !== "string" ||
    !/^v\d+\.\d+\.\d+$/.test(release.tag_name) ||
    release.draft !== false ||
    release.prerelease !== false ||
    !Array.isArray(release.assets)
  ) {
    throw new Error("Expected a published stable IMS release");
  }

  const version = release.tag_name.slice(1);
  const previous = versionFrom(current);
  const comparison = compareVersions(version, previous);
  if (comparison < 0) throw new Error(`Refusing downgrade from ${previous} to ${version}`);
  if (comparison === 0) return { content: undefined, message: `Already at ${version}` };

  const archives = ["darwin_amd64", "darwin_arm64", "linux_amd64", "linux_arm64"].map(
    (platform) => `ims_v${version}_${platform}.tar.gz`,
  );
  const manifestName = `ims_${version}_checksums.txt`;
  const required = ["ims.rb", manifestName, ...archives];
  for (const name of required) {
    const matches = release.assets.filter((asset: { name: unknown }) => asset?.name === name);
    if (matches.length === 0 || matches[0].state !== "uploaded") {
      return { content: undefined, message: `Release ${version} not ready: missing ${name}` };
    }
    if (
      matches.length !== 1 ||
      !Number.isSafeInteger(matches[0].size) ||
      matches[0].size <= 0 ||
      matches[0].size > maximumAssetSize
    ) {
      throw new Error(`Invalid release asset: ${name}`);
    }
  }

  // Construct URLs ourselves; never trust an asset-provided download location.
  const base = `${downloadRoot}${release.tag_name}/`;
  const cask = text(await load(`${base}ims.rb`));
  if (versionFrom(cask) !== version) throw new Error("Cask version does not match release");
  const inspected = inspectCask(cask);
  if (inspected.structure !== inspectCask(current).structure) {
    throw new Error("Cask structure changed; review the generated Ruby manually");
  }

  const manifest = text(await load(`${base}${manifestName}`));
  for (const archive of archives) {
    const hash = inspected.archives.get(archive);
    const entries = manifest.split(/\r?\n/).filter((line) => line.endsWith(`  ${archive}`));
    if (!hash || entries.length !== 1 || entries[0] !== `${hash}  ${archive}`) {
      throw new Error(`Cask/checksum manifest mismatch: ${archive}`);
    }
    if (checksum(await load(`${base}${archive}`)) !== hash) {
      throw new Error(`Downloaded archive checksum mismatch: ${archive}`);
    }
  }

  return { content: cask, message: `Verified IMS ${previous} → ${version}` };
}

async function download(url: string): Promise<Uint8Array> {
  const headers: Record<string, string> = { "User-Agent": "homebrew-stable-ims-updater" };
  // Credentials go only to the fixed API endpoint, never asset redirects.
  if (url === latestURL && process.env.GH_TOKEN) {
    headers.Authorization = `Bearer ${process.env.GH_TOKEN}`;
  }
  const response = await fetch(url, { headers, signal: AbortSignal.timeout(60_000) });
  if (!response.ok) throw new Error(`Download failed (${response.status}): ${url}`);
  const reader = response.body?.getReader();
  if (!reader) throw new Error(`Empty response: ${url}`);
  const chunks: Uint8Array[] = [];
  let size = 0;
  try {
    for (;;) {
      const { done, value } = await reader.read();
      if (done) break;
      size += value.length;
      if (size > maximumAssetSize) throw new Error(`Asset exceeds size limit: ${url}`);
      chunks.push(value);
    }
  } finally {
    await reader.cancel();
  }
  return Buffer.concat(chunks);
}

if (import.meta.main) {
  const args = process.argv.slice(2);
  if (args.some((arg) => arg !== "--write") || args.length > 1) {
    throw new Error("Usage: bun run update:ims [--write]");
  }
  const path = resolve(import.meta.dir, "../Casks/ims.rb");
  const result = await prepareUpdate(await readFile(path, "utf8"), download);
  console.log(result.message);
  if (result.content !== undefined && args.includes("--write")) {
    await writeFile(path, result.content);
  }
}
