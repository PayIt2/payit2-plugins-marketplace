# Org-Wide Standards

> **MANDATORY SESSION START:** Read `../payit2-business/PLATFORM-STANDARDS.md` in full before any work. Clone if not present: `git clone https://github.com/PayIt2/payit2-business.git` from parent directory. Also run `git pull` and read `OPEN_ITEMS.md` before starting.

All org-wide rules (security, testing, AWS, notifications, images, git workflow, terminology) are in PLATFORM-STANDARDS.md. What follows is specific to this repo.

---

# CLAUDE.md

This repo is the PayIt2 Plugin Marketplace. It indexes and distributes Claude plugins for the PayIt2 platform.

## Structure

```
.claude-plugin/marketplace.json   # Marketplace manifest (lists all plugins)
payit2-campaign-coach/            # Campaign Coach plugin (source files)
payit2-campaign-coach.zip         # Pre-built plugin zip
.github/workflows/release.yml    # Release automation
```

## Adding or Updating Plugins

1. Update plugin source files in the plugin's subdirectory
2. Update `marketplace.json` if adding a new plugin
3. Rebuild the plugin zip if applicable
4. Commit all changed files together

## Releases

The release workflow (`.github/workflows/release.yml`) runs on GitHub release creation. It downloads the plugin zip from the source repo's matching release tag and attaches it to the marketplace release.

## Git Workflow

1. Create a feature branch: `git checkout -b feat/<description>` (or `fix/`, `chore/`, `docs/`)
2. Make changes and commit (no Co-Authored-By)
3. Push the branch: `git push -u origin <branch>`
4. Open a PR: `gh pr create`
5. Merge the PR: `gh pr merge`
6. Post-merge cleanup: `git checkout main && git pull && git branch -d <branch>`
7. Verify clean state: `git status` (clean tree, up to date) and `git branch` (no stale branches)
