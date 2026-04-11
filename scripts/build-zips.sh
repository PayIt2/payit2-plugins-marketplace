#!/bin/bash
# Build distributable zip files for the PayIt2 plugin marketplace.
#
# Produces:
#   dist/payit2-plugins-marketplace.zip          — full marketplace (for "Upload to a new marketplace")
#   dist/payit2-campaign-coach-plugin.zip        — full plugin (for "Add to existing marketplace")
#   dist/skills/campaign-creation-skill.zip      — individual skill zips (for "Upload skill" flow)
#   dist/skills/campaign-analytics-skill.zip
#   dist/skills/campaign-promotion-skill.zip
#   dist/skills/campaign-context-skill.zip
#   dist/skills/supporter-engagement-skill.zip

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PLUGIN_DIR="$REPO_ROOT/payit2-campaign-coach"
DIST_DIR="$REPO_ROOT/dist"

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR/skills"

# --- Marketplace zip ---
# Stage a flat structure: marketplace manifest + plugin contents (no wrapper).
staging=$(mktemp -d)
cp -R "$REPO_ROOT/.claude-plugin" "$staging/.claude-plugin"
for plugin_dir in "$REPO_ROOT"/payit2-*/; do
  plugin_name=$(basename "$plugin_dir")
  mkdir -p "$staging/$plugin_name"
  # Copy plugin contents into the named directory
  (cd "$plugin_dir" && find . -not -name '.DS_Store' -not -name '.' | while read -r f; do
    if [ -d "$plugin_dir/$f" ]; then
      mkdir -p "$staging/$plugin_name/$f"
    else
      cp "$plugin_dir/$f" "$staging/$plugin_name/$f"
    fi
  done)
done
cd "$staging"
zip -r "$DIST_DIR/payit2-plugins-marketplace.zip" . -x "*.DS_Store" > /dev/null
cd "$REPO_ROOT"
rm -rf "$staging"
echo "Built: dist/payit2-plugins-marketplace.zip"

# --- Full plugin zip ---
# Zip contents of plugin directory (no wrapper folder), matching official plugin format.
cd "$PLUGIN_DIR"
zip -r "$DIST_DIR/payit2-campaign-coach-plugin.zip" \
  . \
  -x "*.DS_Store" \
  > /dev/null
cd "$REPO_ROOT"
echo "Built: dist/payit2-campaign-coach-plugin.zip"

# --- Individual skill zips ---
# Each zip must contain exactly one SKILL.md, all files inside a top-level folder.
for skill_dir in "$PLUGIN_DIR"/skills/*/; do
  skill_name=$(basename "$skill_dir")

  # Create a temp staging area with the top-level folder
  staging=$(mktemp -d)
  mkdir -p "$staging/$skill_name"
  cp -R "$skill_dir"/* "$staging/$skill_name/"

  cd "$staging"
  zip -r "$DIST_DIR/skills/$skill_name-skill.zip" \
    "$skill_name/" \
    -x "*/.*DS_Store" \
    > /dev/null
  cd "$REPO_ROOT"
  rm -rf "$staging"

  echo "Built: dist/skills/$skill_name-skill.zip"
done

echo ""
echo "Done. Contents of dist/:"
find "$DIST_DIR" -type f -name "*.zip" | sort | while read -r f; do
  size=$(du -h "$f" | cut -f1)
  echo "  $f  ($size)"
done
