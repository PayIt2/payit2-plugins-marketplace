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

## How items are organized — by "why we need to do this"

> Added 2026-06-08 per CEO direction. Items grouped by motivation. Original M-/B-numbered IDs preserve so cross-references still resolve; the sections below this index keep their chronological order.
>
> **Priority order**: Engineering Health first — marketplace is live and serving installs. Launch Gates empty (marketplace is already published). Growth — process docs + plugin expansion.

### Engineering Health — marketplace is live; hygiene stays continuous

_(M-1 manifest refresh closed 2026-06-09; PayIt2-team publishing docs shipped at [`docs/PUBLISHING.md`](PUBLISHING.md); see COMPLETED_ITEMS.md)_

### Launch Gates

_(none — marketplace is already published and serving installs)_

### Growth — distribution + plugin expansion; post-launch, compounds

**Product Features** — additional plugin scopes
B-2 Third-party plugin submission product flow (deferred — needs product spec; covers when/whether/how PayIt2 accepts external developers' plugins into the marketplace)

_(B-1 "Additional plugins" pending reframe — see Q2 / explanation in 2026-06-09 notes below)_

---

## Must-do before V2 dev-complete

_(M-1 closed 2026-06-09 — see COMPLETED_ITEMS.md)_

---

## Backlog (any time after V2 dev-complete)

### B-1. Additional plugins — reframe needed (CEO 2026-06-09)

**CEO question 2026-06-09:** "I do not understand how this would help PayIt2's users."

**Honest answer:** It probably wouldn't, as currently framed. The 4 candidate plugin scopes here (Newsletter agent, Blog agent, Compliance screener, Lookalike marketer) are **internal marketing-automation surfaces**, not user-facing capabilities. They help PayIt2's marketing team produce content and run audience targeting — they don't appear in any organizer's, donor's, payer's, or admin's workflow on the platform.

The 2026-06-05 audit already correctly housed these as Pattern B GHA automations in `payit2-business/OPEN_ITEMS.md` (B-5 Newsletter Writer rebuild on SES, B-9 Blog Social Syndicator, B-7 Executive Update Agent, etc.). Hosting them ALSO in this marketplace as user-installable plugins would be wrong — they're not designed to be installed by anyone outside PayIt2.

**Recommendation:** Cancel B-1 in this repo. The 4 scopes are tracked correctly in `payit2-business/OPEN_ITEMS.md`. Plugin marketplace expansion (in this repo) should only host plugins built for organizers, donors, payers, or admins — Campaign Assistant is the one current example.

**Pending CEO confirmation before cancelling**, in case there's a use case for these as user-installable plugins that I'm not seeing.

### B-2. Third-party plugin submission product flow (deferred for product spec)

**Source:** Original "Marketplace submission process" item from the 2026-04-03 audit. Reframed 2026-06-09: option (b) PayIt2-team publishing docs shipped at [`docs/PUBLISHING.md`](PUBLISHING.md); this item now scoped to option (a) only.

**What this is:** Define the product flow for accepting plugin submissions from external developers (third parties — partners, integrators, customers who build on top of PayIt2) into the PayIt2 marketplace catalog.

**Why deferred:** No real-near-term demand. No external developer has asked to submit a plugin. The 2026-06-05 audit noted three possible interpretations of the original "marketplace submission process" item; option (b) (internal team publishing) was the actual gap and has now been documented. Option (c) (cancel as aspirational) and option (a) (external submission) are distinguishable only by whether external interest materializes.

**What's open:** A product spec covering: (1) eligibility criteria (what kinds of plugins PayIt2 will host vs reject), (2) submission form and review SLA, (3) ongoing-listing requirements (e.g. maintenance commitments), (4) security review process for third-party code, (5) trademark/branding rules for third-party plugins using PayIt2's name, (6) revenue-share decisions if a third-party plugin monetizes via PayIt2.

**Effect when shipped:** PayIt2's marketplace becomes a platform that other developers can build for, not just a private catalog of PayIt2's own plugins. Strategically interesting if the ecosystem grows; pure overhead if it doesn't.

**Effort:** ~4-8 hours of product writing + Thomas signoff + Brian alignment. Most of the cost is in defining policies that haven't been needed yet.

**Reopen trigger:** First external developer who asks to submit a plugin. Until then, "deferred" is the right state.

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
