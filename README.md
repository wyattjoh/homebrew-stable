# homebrew-stable

[Homebrew](https://brew.sh) packages from my personal projects.

## Install Cloudflare DDNS from brew

Tap for the [cloudflare-ddns](https://github.com/wyattjoh/cloudflare-ddns/)
tool.

```sh
brew install wyattjoh/stable/cloudflare-ddns
```

## Install SketchVersion from brew

Tap for the [sketchversion](https://github.com/wyattjoh/sketchversion/) tool.

```sh
brew install wyattjoh/stable/sketchversion
```

## Install Git Publish from brew

Tap for the [git-publish](https://github.com/wyattjoh/git-publish/) tool.

```sh
brew install wyattjoh/stable/git-publish
```

## Install ims from brew

Tap for the [ims](https://github.com/wyattjoh/ims/) tool.

```sh
brew install wyattjoh/stable/ims
```

### Automatic IMS cask updates

The **Update IMS cask** workflow checks the latest stable IMS release hourly and
can also be run manually from GitHub Actions. It validates the generated cask and
all four archive checksums before committing `Casks/ims.rb` with this repository's
`GITHUB_TOKEN`. No cross-repository token is required. Other packages, including
the legacy `Formula/ims.rb`, are not modified.

The IMS release workflow must publish its generated cask as an `ims.rb` release
asset. In the IMS GoReleaser configuration, retain the existing cask fields, set
`homebrew_casks[].skip_upload: true`, and add
`release.extra_files: [{ glob: ./dist/homebrew/Casks/ims.rb }]`. The existing
v1.5.12 release does not have that asset; until an eligible release is available,
the updater reports that the release is not ready and leaves the tap unchanged.

The updater never evaluates downloaded Ruby. It validates the four OS/architecture
blocks independently of their ordering, accepting interpolated URLs or literal
tags only when they resolve to the exact release archive. Version/checksum changes
and GoReleaser's equivalent `zap :not_required` stanza are allowed; all other
structural changes require manual review. Missing or
still-uploading assets defer an update, while invalid metadata, checksums, or
attempted downgrades fail the workflow. Each request has a timeout, and files are
size-limited. Checksums detect inconsistent downloads, not compromise of the
upstream release publisher.

Direct pushes must be permitted by the tap's branch rules. GitHub does not trigger
ordinary push CI for commits made with `GITHUB_TOKEN`, so the updater runs its
checks before committing. Schedules may be delayed, and GitHub disables scheduled
workflows in public repositories after 60 days without repository activity.
Re-enable the schedule in Actions if necessary; manual dispatch remains available.
The workflow only updates the default `master` branch.

To work on the automation locally, use Bun 1.4.4:

```sh
bun install --frozen-lockfile
bun run test
bun run typecheck
bun run lint
bun run format:check
bun run update:ims         # Verify only; do not change the cask
bun run update:ims --write # Write only after complete verification
```

## Install next-dev-utils from brew

Tap for the [next-dev-utils](https://github.com/wyattjoh/next-dev-utils) tool.

```sh
brew install wyattjoh/stable/next-dev-utils
```

## Install vercel-scripts from brew

Tap for the [vercel-scripts](https://github.com/wyattjoh/vercel-scripts) tool.

```sh
brew install wyattjoh/stable/vercel-scripts
```

## Install conduit from brew

Tap for the [conduit](https://github.com/wyattjoh/conduit) tool.

```sh
brew install wyattjoh/stable/conduit
```

## Install resticprofile from brew

Tap for the [resticprofile](https://github.com/wyattjoh/resticprofile) fork.

```sh
brew install wyattjoh/stable/resticprofile
```

## Install pando from brew

Tap for the [pando](https://github.com/wyattjoh/pando) tool.

```sh
brew install wyattjoh/stable/pando
```
