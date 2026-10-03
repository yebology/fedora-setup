#!/bin/bash
# =============================================================================
# Debug why fastfetch logo doesn't update after running fastfetch-full.sh
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/debug-fastfetch.sh)
# =============================================================================

echo "=========================================="
echo "  Fastfetch Debug Report"
echo "=========================================="

echo ""
echo "--- 1. Current local config (~/.config/fastfetch/config.jsonc) ---"
if [ -f ~/.config/fastfetch/config.jsonc ]; then
  cat ~/.config/fastfetch/config.jsonc
  echo ""
  echo "Last modified: $(stat -c '%y' ~/.config/fastfetch/config.jsonc 2>/dev/null || stat -f '%Sm' ~/.config/fastfetch/config.jsonc)"
else
  echo "❌ File does not exist!"
fi

echo ""
echo "--- 2. Script content fetched fresh from GitHub (bypassing cache) ---"
curl -fsSL "https://raw.githubusercontent.com/yebology/fedora-setup/main/fastfetch-full.sh?nocache=$(date +%s)" | grep -A5 '"logo"'

echo ""
echo "--- 3. All config paths fastfetch checks, in priority order ---"
fastfetch --list-config-paths 2>/dev/null

echo ""
echo "--- 4. Fastfetch version ---"
fastfetch --version

echo ""
echo "--- 5. Actual logo fastfetch resolves right now ---"
fastfetch --logo-print-remaining false 2>/dev/null | head -3 || echo "(check manually: run 'fastfetch' and look at the ASCII logo)"

echo ""
echo "=========================================="
echo "  Report complete. Share this output."
echo "=========================================="
