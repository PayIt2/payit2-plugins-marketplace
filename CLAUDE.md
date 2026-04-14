# Org-Wide Standards

> **MANDATORY SESSION START:** Read `../payit2-business/PLATFORM-STANDARDS.md` in full before any work. Clone if not present: `git clone https://github.com/PayIt2/payit2-business.git` from parent directory. Also run `git pull` and read `docs/OPEN_ITEMS.md` before starting.

All org-wide rules (security, testing, AWS, notifications, images, git workflow, terminology) are in PLATFORM-STANDARDS.md. What follows is specific to this repo.

---

# CLAUDE.md

This repo is the PayIt2 Plugin Marketplace. It indexes and distributes Claude plugins for the PayIt2 platform.

## Structure

```
.claude-plugin/marketplace.json   # Marketplace manifest
scripts/build-zips.sh             # Build script (pulls from source repos)
dist/                             # Build output (gitignored)
docs/                             # OPEN_ITEMS.md, COMPLETED_ITEMS.md
.github/workflows/release.yml    # Release automation
```

No plugin source files live here. The build script pulls from sibling source repos (e.g. `../payit2-campaign-assistant/plugin/`).

## Building Zips

Requires sibling repo `payit2-campaign-assistant` to be cloned. Then run:

```bash
bash scripts/build-zips.sh
```

Produces:
- `dist/payit2-plugins-marketplace.zip` - full marketplace (for "Upload to a new marketplace")
- `dist/payit2-campaign-assistant-plugin.zip` - full plugin (for "Upload plugin" flow)
- `dist/skills/<name>-skill.zip` - individual skill zips (for "Upload skill" flow)

## Adding or Updating Plugins

1. Make changes in the source repo (e.g. `payit2-campaign-assistant`)
2. Update `marketplace.json` if adding a new plugin
3. Run `bash scripts/build-zips.sh` to rebuild from source

## Releases

The release workflow checks out both this repo and the source repo, runs the build script, and attaches all zips to the release.

## Git Workflow

See PLATFORM-STANDARDS.md Section 15 for the full git workflow.
