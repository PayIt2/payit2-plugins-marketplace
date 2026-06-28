---
title: "Publishing Process — PayIt2-team workflow for shipping plugin updates"
type: reference
doc_status: active
owner: claude-maintained
---
# Publishing Process — PayIt2-team workflow for shipping plugin updates

This is the internal team workflow for releasing a new version of a plugin already in the PayIt2 marketplace. For the user-facing install instructions, see [README.md](../README.md).

Third-party plugin submission (an external developer asking PayIt2 to include their plugin) is not implemented as a self-serve process. See [OPEN_ITEMS.md](OPEN_ITEMS.md) B-2 for product-spec status.

## When to use this

Use this process when:
- A plugin source repo (e.g. `payit2-campaign-assistant`) has shipped changes you want users to receive
- You're adding a brand-new plugin to the marketplace catalog
- You're rolling back the marketplace pin to an earlier tag of an already-cataloged plugin

Do **not** use this process for:
- Hotfixes inside a plugin's source code — those go in the plugin's own repo first
- Marketplace infrastructure changes (`scripts/build-zips.sh`, `.github/workflows/release.yml`) — those follow the normal Git workflow per PLATFORM-STANDARDS Section 15

## Step 1 — Land the change in the source repo

The source repo is the canonical home of the plugin's code. Make the change there first.

1. In the plugin's source repo (e.g. `payit2-campaign-assistant`), implement the change on a feature branch, open a PR, and merge to `main` per the normal workflow.
2. Once the PR is merged, decide whether the change warrants a new tagged release. Tag bumping rules:
   - **Patch** (`v1.6.0` → `v1.6.1`) — bug fixes, doc-only edits, content updates, terminology fixes
   - **Minor** (`v1.6.0` → `v1.7.0`) — new skill, new agent, additive features that don't break existing usage
   - **Major** (`v1.6.0` → `v2.0.0`) — breaking schema changes, removed skills, manifest changes that existing installs can't auto-recover from
3. From the source repo's `main` with the merge in, tag the release:
   ```bash
   git checkout main
   git pull origin main
   git tag v1.6.1
   git push origin v1.6.1
   ```
4. The plugin's `release.yml` workflow runs automatically on tag push. It builds the plugin zips from the new tag and attaches them to a GitHub release.

If the change does **not** warrant a new tag (e.g. a non-user-visible doc edit), stop here. The marketplace pin doesn't need to move; users running the existing pinned version are not affected.

## Step 2 — Update the marketplace manifest

Open `.claude-plugin/marketplace.json` in this repo.

For an existing plugin (most common case), update the `sha` field of the matching plugin entry to the commit SHA of the new tag:

```bash
gh api repos/PayIt2/<source-repo>/git/refs/tags/v1.6.1 \
  --jq '.object.sha'
```

That command returns the SHA. Paste it into the plugin's `source.sha` field:

```json
{
  "name": "payit2-campaign-assistant",
  "source": {
    "source": "git-subdir",
    "url": "PayIt2/payit2-campaign-assistant",
    "path": "plugin",
    "ref": "main",
    "sha": "1c86b260738cabcc4be6fe09019fa65273041a67"
  },
  "description": "..."
}
```

The `ref: "main"` field is informational (which branch the tag points at). The `sha` is the canonical pin. Claude reads `sha` and ignores `ref` if they disagree.

For a **new** plugin being added to the marketplace for the first time, append a new object to the `plugins` array with `name`, `source` (including `source: "git-subdir"`, `url`, `path` to the plugin folder inside the source repo, `ref`, `sha`), and `description`.

## Step 3 — Open a PR, merge, verify

1. Commit the `marketplace.json` change on a branch named `chore/refresh-marketplace-sha-<version>` (e.g. `chore/refresh-marketplace-sha-v1.6.1`).
2. Open a PR with a clear title (e.g. "chore: bump campaign-assistant pin to v1.6.1"). PR body should include:
   - Source repo + tag + sha being pinned
   - User-visible delta (what changed between the old pin and the new pin)
   - Any breaking-change call-outs
3. Once CI passes and the PR is reviewed, squash-merge to `main` per the normal workflow.
4. Verify the install path works against the updated marketplace. From a fresh Claude Code session:
   ```
   /plugin marketplace remove PayIt2/payit2-plugins-marketplace
   /plugin marketplace add PayIt2/payit2-plugins-marketplace
   /plugin install payit2-campaign-assistant
   ```
   Confirm the installed version matches the new pinned tag (check the plugin's bundled manifest or its CHANGELOG).

## Rolling back

If a new pin causes problems, the rollback is a one-PR revert:

1. Open a new PR that sets `sha` back to the prior known-good value.
2. Squash-merge. Users who reinstall after the merge get the rolled-back version.

There is no need to delete or modify the original problematic release in the source repo — the marketplace pin is the single source of truth for what users get.

## Tagging considerations

A tag (e.g. `v1.6.0`) is human-readable but mutable in principle. A SHA is immutable. The current schema uses both fields — `ref` for documentation, `sha` as the pin. This is intentional. Do **not** drop the `sha` field and rely on `ref` alone; a force-pushed branch on the source repo could otherwise silently change what users install.

## See also

- [README.md](../README.md) — user-facing install instructions
- [OPEN_ITEMS.md](OPEN_ITEMS.md) B-2 — status of the third-party plugin submission product spec (the (a) option from the 2026-06-05 audit, deferred)
- [PLATFORM-STANDARDS.md](../../payit2-business/PLATFORM-STANDARDS.md) Section 15 — org-wide Git workflow
