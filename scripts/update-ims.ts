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

function structure(cask: string): string {
  return (
    cask
      // GoReleaser replaced its historical comment with this declarative stanza.
      .replace(/^\s*# No zap stanza required\s*$/gm, "zap :not_required")
      .replace(/^(\s*version )"\d+\.\d+\.\d+"\s*$/gm, '$1"VERSION"')
      .replace(/^(\s*sha256 )"[a-f0-9]{64}"\s*$/gm, '$1"SHA256"')
      .split("\n")
      .map((line) => line.trim())
      .filter((line) => line !== "")
      .join("\n")
  );
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
  if (structure(cask) !== structure(current)) {
    throw new Error("Cask structure changed; review the generated Ruby manually");
  }

  const manifest = text(await load(`${base}${manifestName}`));
  const hashes = [...cask.matchAll(/^\s*sha256 "([a-f0-9]{64})"\s*$/gm)].map((match) => match[1]);
  const urls = [...cask.matchAll(/^\s*url "([^"\n]+)"\s*$/gm)].map((match) =>
    match[1].replaceAll("#{version}", version),
  );
  if (hashes.length !== 4 || urls.length !== 4) throw new Error("Expected four cask archives");

  for (const [index, archive] of archives.entries()) {
    const url = `${base}${archive}`;
    if (urls[index] !== url) throw new Error(`Unexpected cask archive URL: ${urls[index]}`);
    const entries = manifest.split(/\r?\n/).filter((line) => line.endsWith(`  ${archive}`));
    if (entries.length !== 1 || entries[0] !== `${hashes[index]}  ${archive}`) {
      throw new Error(`Cask/checksum manifest mismatch: ${archive}`);
    }
    if (checksum(await load(url)) !== hashes[index]) {
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
