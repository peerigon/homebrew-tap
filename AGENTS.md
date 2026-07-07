# AGENTS.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository purpose

This is a [Homebrew tap](https://docs.brew.sh/Taps) for Peerigon (`peerigon/homebrew-tap`), providing custom Homebrew formulae not available in homebrew-core. Users install packages via:

```
brew install peerigon/tap/<formula-name>
```

## Structure

- `Formula/*.rb` — one Ruby file per formula, named after the package (e.g. `Formula/peer-tem.rb` defines the `PeerTem` class).
- Each formula points `url` at a GitHub Releases asset (zip of a prebuilt binary) hosted in the corresponding project's repo release (e.g. `peerigon/peer-tem`), pins a `sha256`, and installs the binary into `bin`.

## Updating a formula for a new release

When bumping a formula to a new upstream version, first check where the formula's `url` points:

### Case A: `url` points at the upstream project's own repo

The upstream repo's release assets are public and can be linked directly.

1. Update `url` to point at the new release asset tag/filename.
2. Update `version` to match.
3. Recompute and update `sha256` to match the new asset's checksum — download the asset and run `shasum -a 256 <file>` (do not guess or reuse the old hash).
4. Keep `install` and `caveats`/`test` blocks unless the upstream binary name or CLI behavior changed.

### Case B: `url` points at a release in this `homebrew-tap` repo instead

`brew install` downloads anonymously, so if the upstream project's repo is **private**, its release assets can't be linked directly — Homebrew can't authenticate to fetch them. The workaround: mirror the built binary as an asset on a release in this public repo, and point the formula at that instead.

**Never overwrite an existing tap release's asset.** Homebrew caches downloads keyed by URL and assumes a given URL's content never changes. Reusing one release/tag across upstream versions and clobbering its asset can serve a stale cached file or a checksum mismatch to users who already downloaded the old version. Instead, create a new release per upstream version:

1. Find the upstream project's latest release and download its binary asset (e.g. `gh release download <tag> --repo <owner>/<upstream-repo> --pattern "<asset-name>"`).
2. Verify its checksum against the digest reported by the upstream release, if available.
3. Create a **new** release in this repo tagged uniquely per package and version — e.g. `<formula>-v<version>` such as `peer-tem-v1.3.0` — so tags don't collide across formulas in this tap, and upload the asset to it (e.g. `gh release create <formula>-v<version> --repo peerigon/homebrew-tap <file>`). Do not reuse or overwrite a prior release for the same formula.
4. Update `url` in the formula to point at the new release tag/asset.
5. Update `version` in the formula to the new upstream version.
6. Update `sha256` in the formula to the new asset's checksum.
7. Keep `install` and `caveats`/`test` blocks unless the upstream binary name or CLI behavior changed.

Leave prior versions' releases in place — they provide rollback and an audit trail of what was actually shipped.

This pattern applies to any formula in this tap whose upstream repo is private, not just one specific project — check each formula's `url` to see which case applies.

## Testing changes

Formulae can be validated locally with standard Homebrew tooling:

```
brew audit --strict Formula/<name>.rb
brew install --build-from-source Formula/<name>.rb
brew test <name>
```

There is no other build, lint, or test tooling in this repository.
