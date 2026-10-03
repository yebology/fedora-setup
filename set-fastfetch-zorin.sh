#!/bin/bash
# =============================================================================
# Switch fastfetch logo to Zorin
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/set-fastfetch-zorin.sh)
# =============================================================================

CONFIG_PATH="$HOME/.config/fastfetch/config.jsonc"

if [ ! -f "$CONFIG_PATH" ]; then
  echo "❌ $CONFIG_PATH not found. Run fastfetch-full.sh first."
  exit 1
fi

sed -i 's/"source": "[^"]*"/"source": "zorin"/' "$CONFIG_PATH"

echo "✅ Done! Logo set to Zorin."
echo "   Restart Ghostty completely (close all windows, reopen) to see the change."
