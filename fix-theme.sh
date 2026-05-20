#!/bin/bash
# =============================================================================
# Set Ghostty theme to GitHub Dark Default
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-theme.sh)
# =============================================================================

sed -i 's/theme = .*/theme = GitHub Dark Default/' ~/.config/ghostty/config

echo "✅ Done! Restart Ghostty."
