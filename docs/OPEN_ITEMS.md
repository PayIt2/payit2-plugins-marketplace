# Open Items

> **Platform roadmap:** See PLATFORM-STANDARDS.md Section 19 for the org-wide implementation phases.

Outstanding work for the PayIt2 Plugins Marketplace.

---

## Audit Issues (2026-04-03)

- [ ] **Version mismatch between repos** — `plugin.json` declares v1.1.0, marketplace release is tagged v1.1 (not v1.1.0), and `payit2-campaign-coach` repo's latest release is still v1.0.4. The campaign-coach repo never got a v1.1.x release, so the release workflow's fallback pulls the v1.0.4 zip instead of 1.1.0 content.
- [ ] **Stale zip committed in repo root** — `payit2-campaign-coach.zip` is committed directly in the repo. This can drift out of sync with the release asset and confuse users who clone vs. download from releases.
- [ ] **Release workflow cross-repo permissions** — `release.yml` uses `GITHUB_TOKEN` to download from `payit2-campaign-coach` (a private repo). The default `GITHUB_TOKEN` is scoped to the current repo and may not have read access to the private repo, causing silent fallback or failure.
- [ ] **README install instructions reference unverified commands** — `/plugin marketplace add` and `/plugin install` are listed as Claude Code commands. Verify these are actually supported in Claude Code today; update or annotate if aspirational.
- [ ] **Claude Desktop install path may be outdated** — "Open the Customize menu (under the co-work or code tabs)" references Claude Desktop UI that changes frequently. Verify current accuracy.

## Planned Work

- [ ] **Additional plugins** — Newsletter agent, blog agent, compliance screener, lookalike marketer. See `payit2-business/agents/` for specs.
- [ ] **Marketplace submission process** — Document how third-party plugins can be submitted.
