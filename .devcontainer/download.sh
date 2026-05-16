#!/bin/bash
# Bundles the workspace into a timestamped zip so students can save their
# project locally via right-click -> Download in the file explorer.

set -e

clear
echo "📦 Bundling your work..."
echo ""

# Remove any older zips so the Explorer stays tidy.
# The student's download history on their laptop is what matters,
# not keeping older snapshots in the Codespace.
rm -f my-work*.zip

# Timestamp in the filename so each download to the laptop is uniquely
# named (e.g. my-work-2026-05-16_14-32.zip).
TIMESTAMP=$(date '+%Y-%m-%d_%H-%M')
ZIP_NAME="my-work-${TIMESTAMP}.zip"

zip -rq "$ZIP_NAME" . \
  -x ".git/*" "*/.git/*" \
     "__pycache__/*" "*/__pycache__/*" \
     "*.pyc" "*.zip" \
     "node_modules/*"

echo "✓ Done! Created: $ZIP_NAME"
echo ""
echo "Now: right-click '$ZIP_NAME' in the Explorer (left sidebar)"
echo "     and choose 'Download...' to save it to your computer."
