#!/bin/bash
# Build distributable zip files for the PayIt2 plugin marketplace.
#
# Produces:
#   dist/payit2-plugins-marketplace.zip     — full marketplace (for "Upload to a new marketplace")
#   dist/payit2-campaign-coach.zip          — full plugin (for "Upload plugin" / "Add to existing marketplace")
#   dist/skills/campaign-creation.zip       — individual skill zips (for "Upload skill" flow)
#   dist/skills/campaign-analytics.zip
#   dist/skills/campaign-promotion.zip
#   dist/skills/campaign-context.zip
#   dist/skills/supporter-engagement.zip

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_DIR="$REPO_ROOT/payit2-campaign-coach"
DIST_DIR="$REPO_ROOT/dist"

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR/skills"

# --- Marketplace zip ---
# Contains the manifest and all plugin folders.
cd "$REPO_ROOT"
zip -r "$DIST_DIR/payit2-plugins-marketplace.zip" \
  .claude-plugin/marketplace.json \
  payit2-campaign-coach/ \
  -x "*/.*DS_Store" \
  > /dev/null
echo "Built: dist/payit2-plugins-marketplace.zip"

# --- Full plugin zip ---
# All files must be inside a top-level folder named after the plugin.
zip -r "$DIST_DIR/payit2-campaign-coach.zip" \
  payit2-campaign-coach/ \
  -x "*/.*DS_Store" \
  > /dev/null
echo "Built: dist/payit2-campaign-coach.zip"

# --- Individual skill zips ---
# Each zip must contain exactly one SKILL.md, all files inside a top-level folder.
for skill_dir in "$PLUGIN_DIR"/skills/*/; do
  skill_name=$(basename "$skill_dir")

  # Create a temp staging area with the top-level folder
  staging=$(mktemp -d)
  mkdir -p "$staging/$skill_name"
  cp -R "$skill_dir"/* "$staging/$skill_name/"

  cd "$staging"
  zip -r "$DIST_DIR/skills/$skill_name.zip" \
    "$skill_name/" \
    -x "*/.*DS_Store" \
    > /dev/null
  cd "$REPO_ROOT"
  rm -rf "$staging"

  echo "Built: dist/skills/$skill_name.zip"
done

echo ""
echo "Done. Contents of dist/:"
find "$DIST_DIR" -type f -name "*.zip" | sort | while read -r f; do
  size=$(du -h "$f" | cut -f1)
  echo "  $f  ($size)"
done
