#!/bin/bash
# Build distributable zip files for the PayIt2 plugin marketplace.
#
# Source of truth: ../payit2-campaign-coach/plugin/ (the campaign-coach source repo).
# This script pulls from there — no plugin files are stored in this repo.
#
# Produces:
#   dist/payit2-campaign-coach-plugin.zip        — full plugin (for "Upload plugin" flow)
#   dist/payit2-plugins-marketplace.zip          — marketplace (for "Upload to a new marketplace")
#   dist/skills/<name>-skill.zip                 — individual skill zips (for "Upload skill" flow)

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SOURCE_PLUGIN="$(cd "$REPO_ROOT/../payit2-campaign-coach/plugin" 2>/dev/null && pwd)"
DIST_DIR="$REPO_ROOT/dist"

if [ ! -d "$SOURCE_PLUGIN" ]; then
  echo "Error: payit2-campaign-coach repo not found at ../payit2-campaign-coach"
  echo "Clone it first: git clone https://github.com/PayIt2/payit2-campaign-coach.git"
  exit 1
fi

rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR/skills"

# --- Full plugin zip ---
# Zip contents of source plugin directory (no wrapper folder).
cd "$SOURCE_PLUGIN"
zip -r "$DIST_DIR/payit2-campaign-coach-plugin.zip" \
  . \
  -x "*.DS_Store" \
  > /dev/null
cd "$REPO_ROOT"
echo "Built: dist/payit2-campaign-coach-plugin.zip"

# --- Marketplace zip ---
# Same as plugin zip but with marketplace.json added alongside plugin.json.
staging=$(mktemp -d)
cd "$SOURCE_PLUGIN"
find . -not -name '.DS_Store' -not -path './.DS_Store' | while read -r f; do
  if [ -d "$f" ]; then
    mkdir -p "$staging/$f"
  else
    cp "$f" "$staging/$f"
  fi
done
cp "$REPO_ROOT/.claude-plugin/marketplace.json" "$staging/.claude-plugin/"
cd "$staging"
zip -r "$DIST_DIR/payit2-plugins-marketplace.zip" . -x "*.DS_Store" > /dev/null
cd "$REPO_ROOT"
rm -rf "$staging"
echo "Built: dist/payit2-plugins-marketplace.zip"

# --- Individual skill zips ---
# Each zip must contain exactly one SKILL.md, all files inside a top-level folder.
for skill_dir in "$SOURCE_PLUGIN"/skills/*/; do
  skill_name=$(basename "$skill_dir")

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
