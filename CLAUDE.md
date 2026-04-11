# Org-Wide Standards

> **MANDATORY SESSION START:** Read `../payit2-business/PLATFORM-STANDARDS.md` in full before any work. Clone if not present: `git clone https://github.com/PayIt2/payit2-business.git` from parent directory. Also run `git pull` and read `docs/OPEN_ITEMS.md` before starting.

All org-wide rules (security, testing, AWS, notifications, images, git workflow, terminology) are in PLATFORM-STANDARDS.md. What follows is specific to this repo.

---

# CLAUDE.md

This repo is the PayIt2 Plugin Marketplace. It indexes and distributes Claude plugins for the PayIt2 platform.

## Structure

```
.claude-plugin/marketplace.json   # Marketplace manifest (lists all plugins)
payit2-campaign-coach/            # Campaign Coach plugin (source files)
scripts/build-zips.sh             # Build script for all distributable zips
dist/                             # Build output (gitignored)
docs/                             # OPEN_ITEMS.md, COMPLETED_ITEMS.md
.github/workflows/release.yml    # Release automation
```

## Building Zips

Run `bash scripts/build-zips.sh` to produce:
- `dist/payit2-campaign-coach.zip` - full plugin zip (for "Upload plugin" flow)
- `dist/skills/<name>.zip` - individual skill zips (for "Upload skill" flow)

Each skill zip contains exactly one SKILL.md inside a top-level folder.

## Adding or Updating Plugins

1. Update plugin source files in the plugin's subdirectory
2. Update `marketplace.json` if adding a new plugin
3. Run `bash scripts/build-zips.sh` to rebuild
4. Commit source changes (zips are built by CI on release)

## Releases

The release workflow (`.github/workflows/release.yml`) runs on GitHub release creation. It downloads the plugin zip from the source repo's matching release tag and attaches it to the marketplace release.

## Git Workflow

See PLATFORM-STANDARDS.md Section 15 for the full git workflow.
