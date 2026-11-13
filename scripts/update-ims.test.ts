import { describe, expect, test } from "bun:test";
import { createHash } from "node:crypto";
import { readFileSync } from "node:fs";
import { prepareUpdate } from "./update-ims";

const current = readFileSync(new URL("../Casks/ims.rb", import.meta.url), "utf8");
const previous = current.match(/version "([^"]+)"/)![1];
const parts = previous.split(".");
const version = `${parts[0]}.${parts[1]}.${BigInt(parts[2]) + 1n}`;
const api = "https://api.github.com/repos/wyattjoh/ims/releases/latest";
const base = `https://github.com/wyattjoh/ims/releases/download/v${version}/`;
const bytes = (value: string) => new TextEncoder().encode(value);

function fixture() {
  const files = new Map<string, Uint8Array>();
  const archives = ["darwin_amd64", "darwin_arm64", "linux_amd64", "linux_arm64"].map(
    (platform) => `ims_v${version}_${platform}.tar.gz`,
  );
  const hashes = archives.map((name) => {
    const content = bytes(`archive fixture: ${name}`);
    files.set(`${base}${name}`, content);
    return createHash("sha256").update(content).digest("hex");
  });
  let index = 0;
  const cask = current
    .replace(`version "${previous}"`, `version "${version}"`)
    .replace(/sha256 "[a-f0-9]{64}"/g, () => `sha256 "${hashes[index++]}"`);
  files.set(`${base}ims.rb`, bytes(cask));
  const manifest = `ims_${version}_checksums.txt`;
  files.set(
    `${base}${manifest}`,
    bytes(archives.map((name, i) => `${hashes[i]}  ${name}`).join("\n")),
  );
  const release = {
    tag_name: `v${version}`,
    draft: false,
    prerelease: false,
    assets: ["ims.rb", manifest, ...archives].map((name) => ({
      name,
      state: "uploaded",
      size: files.get(`${base}${name}`)!.length,
    })),
  };
  const calls: string[] = [];
  const load = async (url: string) => {
    calls.push(url);
    if (url === api) return bytes(JSON.stringify(release));
    const value = files.get(url);
    if (!value) throw new Error(`Unexpected request: ${url}`);
    return value;
  };
  return { files, release, load, cask, archives, manifest, calls };
}

describe("IMS cask updater", () => {
  test("accepts the generated cask after verifying all four archives", async () => {
    const f = fixture();
    const result = await prepareUpdate(current, f.load);
    expect(result.content).toBe(f.cask);
    expect(f.calls).toHaveLength(7);
  });

  test("accepts GoReleaser's current no-zap stanza", async () => {
    const f = fixture();
    const updated = f.cask.replace("# No zap stanza required", "zap :not_required");
    f.files.set(`${base}ims.rb`, bytes(updated));
    expect((await prepareUpdate(current, f.load)).content).toBe(updated);
  });

  test("accepts an exact literal release tag in cask URLs", async () => {
    const f = fixture();
    const cask = f.cask.replaceAll("/v#{version}/", `/v${version}/`);
    f.files.set(`${base}ims.rb`, bytes(cask));
    expect((await prepareUpdate(current, f.load)).content).toBe(cask);
  });

  test("accepts real GoReleaser v2.20.2 output with ARM blocks first", async () => {
    const f = fixture();
    const generated = readFileSync(
      new URL("fixtures/goreleaser-v2.20.2.rb", import.meta.url),
      "utf8",
    );
    // Keep the real generated structure; substitute stable release metadata and
    // the archive hashes used by this deterministic, network-free fixture.
    const cask = generated
      .replace('version "1.5.12-SNAPSHOT-da4661c"', `version "${version}"`)
      .replaceAll("/v1.5.12/", `/v${version}/`)
      .replace(
        /sha256 "[a-f0-9]{64}"(\s+url "[^"\n]+_(darwin|linux)_(amd64|arm64)\.tar\.gz")/g,
        (_match, suffix: string, os: string, arch: string) => {
          const archive = f.files.get(`${base}ims_v${version}_${os}_${arch}.tar.gz`)!;
          return `sha256 "${createHash("sha256").update(archive).digest("hex")}"${suffix}`;
        },
      );
    f.files.set(`${base}ims.rb`, bytes(cask));
    expect((await prepareUpdate(current, f.load)).content).toBe(cask);
  });

  test("already-current versions do not download assets or rewrite the cask", async () => {
    const f = fixture();
    f.release.tag_name = `v${previous}`;
    expect((await prepareUpdate(current, f.load)).content).toBeUndefined();
    expect(f.calls).toEqual([api]);
  });

  test("rejects downgrades using numeric rather than lexicographic comparison", async () => {
    const f = fixture();
    f.release.tag_name = "v0.99.99";
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("Refusing downgrade");
  });

  test.each(["v1.2.3-rc1", "malformed", "v1.2.3/evil"])("rejects tag %s", async (tag) => {
    const f = fixture();
    f.release.tag_name = tag;
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("published stable");
  });

  test.each(["draft", "prerelease"] as const)("rejects %s releases", async (field) => {
    const f = fixture();
    f.release[field] = true;
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("published stable");
  });

  test("defers incomplete releases without downloading assets", async () => {
    const f = fixture();
    f.release.assets.pop();
    const result = await prepareUpdate(current, f.load);
    expect(result.content).toBeUndefined();
    expect(result.message).toContain("not ready");
    expect(f.calls).toEqual([api]);
  });

  test("defers assets that are still uploading", async () => {
    const f = fixture();
    f.release.assets[0].state = "new";
    expect((await prepareUpdate(current, f.load)).content).toBeUndefined();
  });

  test("rejects duplicate assets", async () => {
    const f = fixture();
    f.release.assets.push(f.release.assets[0]);
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("Invalid release asset");
  });

  test("rejects oversized assets", async () => {
    const f = fixture();
    f.release.assets[0].size = 256 * 1024 * 1024;
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("Invalid release asset");
  });

  test("rejects a cask version that differs from its release", async () => {
    const f = fixture();
    f.files.set(`${base}ims.rb`, bytes(current));
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("version does not match");
  });

  test("rejects added Ruby instead of evaluating it", async () => {
    const f = fixture();
    f.files.set(`${base}ims.rb`, bytes(`${f.cask}\nsystem 'untrusted command'\n`));
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("structure changed");
  });

  test("rejects changed download origins", async () => {
    const f = fixture();
    f.files.set(`${base}ims.rb`, bytes(f.cask.replaceAll("github.com", "example.com")));
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("Unexpected cask archive URL");
  });

  test("rejects a literal URL for a different release", async () => {
    const f = fixture();
    f.files.set(`${base}ims.rb`, bytes(f.cask.replaceAll("/v#{version}/", "/v0.0.1/")));
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("Unexpected cask archive URL");
  });

  test("rejects an archive assigned to the wrong architecture", async () => {
    const f = fixture();
    f.files.set(`${base}ims.rb`, bytes(f.cask.replaceAll("on_intel do", "on_arm do")));
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("Unexpected cask archive URL");
  });

  test("rejects duplicate OS blocks", async () => {
    const f = fixture();
    f.files.set(
      `${base}ims.rb`,
      bytes(f.cask.replace("on_linux do", "on_macos do").replaceAll("_linux_", "_darwin_")),
    );
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("Duplicate cask platform");
  });

  test("rejects injected Ruby inside a platform block", async () => {
    const f = fixture();
    f.files.set(
      `${base}ims.rb`,
      bytes(f.cask.replace("on_arm do", "on_arm do\n      system 'bad'")),
    );
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("structure changed");
  });

  test("rejects mismatched manifest checksums", async () => {
    const f = fixture();
    f.files.set(`${base}${f.manifest}`, bytes(`invalid  ${f.archives[0]}`));
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("manifest mismatch");
  });

  test("rejects duplicate manifest entries", async () => {
    const f = fixture();
    const manifest = f.files.get(`${base}${f.manifest}`)!;
    f.files.set(
      `${base}${f.manifest}`,
      bytes(`${new TextDecoder().decode(manifest)}\n${new TextDecoder().decode(manifest)}`),
    );
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("manifest mismatch");
  });

  test("rejects corrupted archive bytes", async () => {
    const f = fixture();
    f.files.set(`${base}${f.archives[0]}`, bytes("corrupted archive"));
    await expect(prepareUpdate(current, f.load)).rejects.toThrow("archive checksum mismatch");
  });

  test("propagates request failures without returning an update", async () => {
    await expect(
      prepareUpdate(current, async () => {
        throw new Error("HTTP 403");
      }),
    ).rejects.toThrow("HTTP 403");
  });
});
