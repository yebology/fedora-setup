#!/bin/bash
# =============================================================================
# Fix fastfetch color on Ghostty (xterm-ghostty terminfo issue)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

# Remove term override from Ghostty config
sed -i '/^term = /d' ~/.config/ghostty/config 2>/dev/null

# Clean old fastfetch and TERM lines from .zshrc
sed -i '/fastfetch/d' ~/.zshrc
sed -i '/export TERM/d' ~/.zshrc
sed -i '/TERM=xterm/d' ~/.zshrc

# Add export TERM before fastfetch in .zshrc
echo 'export TERM=xterm-256color' >> ~/.zshrc
echo 'fastfetch' >> ~/.zshrc

echo "✅ Done! Close ALL Ghostty windows and reopen."
echo ""
echo "   If still white after reopen, run:"
echo "   sudo dnf install -y ghostty-terminfo"
echo "   Then remove the TERM export:"
echo "   sed -i '/export TERM/d' ~/.zshrc"
