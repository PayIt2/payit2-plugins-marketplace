# Completed Items

Items completed from OPEN_ITEMS.md, with date and outcome.

---

## 2026-06-09 (manifest refresh + team publishing docs)

- **M-1. Refresh `marketplace.json` to point at the latest published campaign-assistant tag** — Updated the `sha` field of the `payit2-campaign-assistant` plugin entry from `c12961784334848f3c7b754cc44e3400e2cca613` (an intermediate "fix(release): align release.sh" commit) to `1c86b260738cabcc4be6fe09019fa65273041a67` (the v1.6.0 release tag's commit). Users who install via `/plugin marketplace add PayIt2/payit2-plugins-marketplace` + `/plugin install payit2-campaign-assistant` now get the v1.6.0 release.

  Considered pinning to a tag (`ref: "v1.6.0"`) instead of a sha for cleaner future updates. Kept `ref: "main"` + `sha: <commit>` per existing schema; the sha is the canonical pin and `ref` is informational. Tag-based pinning would be a schema change requiring marketplace-tooling verification.

- **B-2 option (b). PayIt2-team publishing process docs** — Shipped at [`docs/PUBLISHING.md`](docs/PUBLISHING.md). Covers (1) when to use the process, (2) tag-bumping rules (patch/minor/major), (3) source-repo workflow (PR → merge → tag → release), (4) updating the marketplace manifest sha, (5) PR review + verification flow, (6) rollback procedure, (7) tag-vs-sha schema rationale. Resolves Q1's option (b) interpretation of the original "marketplace submission process" item.

  Note: option (a) (third-party plugin submission flow for external developers) is a separate, deferred product spec — see OPEN_ITEMS.md B-2 for the reframed item with reopen trigger.

---

## 2026-06-05 (audit pass resolutions)

Items from the 2026-04-03 "Audit Issues" section that were verified resolved during the 2026-06-05 OPEN_ITEMS reorganization audit. Verified by direct repo inspection (not paper exercise).

- **Stale zip committed in repo root** — Resolved. The original `payit2-campaign-assistant.zip` is no longer committed at repo root. Repo top-level is now clean (CLAUDE.md, README.md, docs/, scripts/, .github/, .claude-plugin/). Build artifacts go to `dist/` (gitignored).
- **Release workflow cross-repo permissions** — Resolved by external change. The `payit2-campaign-assistant` source repo is now PUBLIC (verified via `gh repo view`). The release workflow's use of the default `GITHUB_TOKEN` for cross-repo checkout works fine for public repos — the original concern about silent fallback on a private repo no longer applies.
- **README install instructions reference unverified commands** — Resolved. `/plugin marketplace add` and `/plugin install` are now confirmed working — the live payit2.com/ai-assistant.html install instructions use the same commands. README install flow uses confirmed-working "Settings > Plugins > Upload" wording.
- **Claude Desktop install path may be outdated** — Resolved. Current README uses "Settings > Plugins > Upload" wording rather than the old "Customize menu" path the April audit was worried about.

---

## 2026-04-03

- CLAUDE.md created (mandatory session start, repo guide, git workflow referencing PLATFORM-STANDARDS Section 15)
- .github/PULL_REQUEST_TEMPLATE.md added
- OPEN_ITEMS.md: audit issues logged (version mismatch, stale zip, cross-repo permissions, unverified install commands, outdated Claude Desktop instructions); roadmap reference added (Section 19)
