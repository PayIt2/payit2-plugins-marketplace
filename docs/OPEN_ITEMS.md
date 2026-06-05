# Open Items — payit2-plugins-marketplace

> **Platform roadmap:** See `../../payit2-business/PLATFORM-STANDARDS.md` Section 19 for the org-wide implementation phases.
>
> **Structure (2026-06-05 audit, classifier-mode rebuild):** Single prioritized list. Items 1–N are **must-do before V2 dev-complete** (the stage where board members begin testing V2 platform). Items N+1 onward are **backlog** (any time after V2 dev-complete; can be picked from at will). History (date, prior rationale, source PR) is preserved inline per item. `⚠️ NEEDS THOMAS` tags items where I couldn't classify alone — resolve at the top.
>
> Items resolved during the audit move to [`COMPLETED_ITEMS.md`](COMPLETED_ITEMS.md). Items cancelled get a one-line note in the audit log at the bottom.
>
> **Last audit:** 2026-06-05. Audit method: every item verified against current repo state (git tags, file existence, workflow YAML, repo visibility via `gh repo view`).

---

## Verification notes from this audit

- **What this repo is:** PayIt2's own private "app store" for Claude plugins. The critical file is `.claude-plugin/marketplace.json` — a catalog that Claude reads when a user runs `/plugin marketplace add PayIt2/payit2-plugins-marketplace`. The catalog lists available plugins and points at their source repos. A user who has added the marketplace can then `/plugin install <plugin-name>` directly.
- **Why have it (vs. just using Claude's central public Discover tab):** Control over publishing (no Anthropic approval gating), supports beta / preview plugins, single subscribe gives users access to everything PayIt2 ever publishes, lets us host plugins that wouldn't fit Anthropic's central catalog.
- **What's currently published:** One plugin — `payit2-campaign-assistant` (sourced from `PayIt2/payit2-campaign-assistant` on GitHub).

---

## ⚠️ Open questions

> Two audiences: `[FOR THOMAS]` are items only the CEO can decide. `[FOR BRIAN]` are items where Thomas has no context and needs Brian's clarification (per his 2026-06-05 instruction: surface to Brian with full detail). Both flow back into this same list — items unblock once whoever's tagged answers.

**Q1 [FOR BRIAN]. "Marketplace submission process for third-party plugins"** — original OPEN_ITEMS item from 2026-04-03 said to "document how third-party plugins can be submitted." Three possible meanings:

- **(a) Real product direction** — third-party developers (PayIt2 customers, partners, integrators) submit plugins that PayIt2's customers can install via our marketplace. Treat as a future product feature.
- **(b) Misframed** — what was really meant was a documented process for the PayIt2 *team* (Brian, Thomas, contractors) to ship NEW PayIt2 plugins through the marketplace.
- **(c) Cancel** — third-party submission isn't a product direction; aspirational item that doesn't belong on the list.

**For Brian:** Which of (a) / (b) / (c) did you have in mind when this item was logged? If (a), is this real near-term product strategy or a someday-maybe? If (b), should we capture the publishing process in the marketplace repo's CLAUDE.md as the only doc that needs to exist? If (c), cancel and remove.

Thomas (2026-06-05): "I have no idea — mark as item for Brian to confirm."

**Q2 [FOR THOMAS]. "Additional plugins" — Newsletter agent, blog agent, compliance screener, lookalike marketer.** These overlap with items in `payit2-business`'s plugin/agent backlog (which Thomas said he doesn't remember). Defer until business audit — Thomas will review the 11 plugin scopes there and decide which are wanted.

---

## Must-do before V2 dev-complete

### M-1. Refresh `marketplace.json` to point at the latest published campaign-assistant tag
**Source:** Original item from 2026-04-03 audit ("Version mismatch between repos"), updated 2026-06-05.
**Verified 2026-06-05:**
- `marketplace.json` pins `sha: c12961784334848f3c7b754cc44e3400e2cca613` (commit `c129617`, an intermediate "fix(release): align release.sh with marketplace's actual workflow" commit)
- Campaign-assistant has shipped v1.6.0 since — sha `1c86b260738cabcc4be6fe09019fa65273041a67`
- Plus a newer documentation commit on main, `02a0620`

So users who add the marketplace today get an older version of the plugin than the latest tagged release. The release workflow (`release.yml`) does build from current `main` of the source repo when triggered, but the manifest in `master`'s `marketplace.json` is the canonical reference Claude reads — so it overrides any newer build until manifest is updated and committed.
**Classification rationale:** Anyone who installs PayIt2 Campaign Assistant from the marketplace before V2 dev-complete gets a stale version. Worth fixing before board members test. **Must-do.**
**Scope of fix:** Update sha in `.claude-plugin/marketplace.json` to v1.6.0 sha; consider whether to pin a tag (`v1.6.0`) instead of a sha for future updates to be cleaner.

---

## Backlog (any time after V2 dev-complete)

### B-1. Additional plugins — gated on Q2 above
**Source:** Original "Planned Work" item from OPEN_ITEMS.
**Verified 2026-06-05:** ✅ Real. Specs exist in `payit2-business/agents/`. These overlap with the 11 plugin scopes in payit2-business OPEN_ITEMS that Thomas hasn't reviewed yet.
**Classification rationale:** Won't classify until Q2 resolved during business repo audit.

### B-2. Document publishing process (resolves Q1 above pending answer)
**Source:** Original "Marketplace submission process" item from OPEN_ITEMS.
**Verified 2026-06-05:** Doc doesn't exist. Open work.
**Classification rationale:** Backlog regardless of Q1 answer — neither (a) third-party submission nor (b) PayIt2-team-shipping docs is a dev-complete blocker.

---

## Audit log (2026-06-05)

- **Method:** Each item verified against (a) current repo state — `gh repo view`, git tags, file existence, release workflow YAML — and (b) cross-repo state — campaign-assistant sha + release tags.
- **4 items resolved as already done; moved to COMPLETED_ITEMS.md:**
  - "Stale zip committed in repo root" — no zips in root anymore
  - "Release workflow cross-repo permissions" — campaign-assistant is now PUBLIC, so GITHUB_TOKEN works without elevated permissions
  - "README install instructions reference unverified commands" — `/plugin marketplace add` confirmed working on live payit2.com
  - "Claude Desktop install path may be outdated" — current README uses "Settings > Plugins > Upload" wording, not the old "Customize menu" path
- **1 item reframed:** "Version mismatch between repos" → M-1 "Refresh marketplace.json sha to latest published campaign-assistant tag" (specifics updated; version numbers in original item were from April).
- **2 items still open with updated framing:** B-1 (additional plugins, gated on business audit), B-2 (publishing/submission process, gated on Q1).
- **Naming note:** Confirmed via `gh repo view PayIt2/payit2-campaign-coach` → returns `name: payit2-campaign-assistant`. The GitHub-side rename has happened. Local clones still using the old dir name are cosmetic only. (This cancels the "B-2 rename repo" item I had wrongly added to the campaign-coach audit.)
