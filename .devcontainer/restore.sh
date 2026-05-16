#!/bin/bash
# Restores a previously-downloaded zip (e.g. my-work-2026-05-16_14-32.zip)
# by extracting it into the workspace, so students can pick up work from
# an earlier session in a fresh Codespace.

set -e

clear
echo "📂 Looking for a zip file to restore..."
echo ""

# Find the most recently modified zip in the workspace root.
ZIP_FILE=""
if ls *.zip >/dev/null 2>&1; then
  ZIP_FILE=$(ls -t *.zip | head -n1)
fi

if [ -z "$ZIP_FILE" ]; then
  echo "✗ No zip file found in the workspace."
  echo ""
  echo "First, drag your saved 'my-work-*.zip' from your computer into the"
  echo "Explorer panel on the left (or right-click in Explorer → Upload...),"
  echo "then click the 📂 Restore my work button again."
  exit 1
fi

echo "Restoring from: $ZIP_FILE"
echo ""

unzip -oq "$ZIP_FILE"

# Remove the zip after extraction so it doesn't get re-bundled into
# future Downloads and doesn't clutter the Explorer.
rm -f "$ZIP_FILE"

echo "✓ Done! Your files have been restored."
echo ""
echo "You can now keep coding where you left off."
