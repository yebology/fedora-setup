#!/bin/bash
# =============================================================================
# Fix fastfetch color on Ghostty (attempt 4 - timing fix)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

# Clean old fastfetch and TERM lines from .zshrc
sed -i '/fastfetch/d' ~/.zshrc
sed -i '/export TERM/d' ~/.zshrc
sed -i '/TERM=xterm/d' ~/.zshrc
sed -i '/FASTFETCH_DONE/d' ~/.zshrc
sed -i '/precmd/d' ~/.zshrc

# Add fastfetch that runs once after shell is fully loaded
cat >> ~/.zshrc << 'EOF'
# Run fastfetch once on first prompt (after everything is loaded)
if [[ -z $FASTFETCH_DONE ]]; then
  export TERM=xterm-256color
  fastfetch
  export FASTFETCH_DONE=1
fi
EOF

echo "✅ Done! Close ALL Ghostty windows and reopen."
echo ""
echo "   Debug: after reopen, if still white, type these and share output:"
echo "   1. echo \$TERM"
echo "   2. fastfetch"
echo "   (is manual fastfetch blue or white?)"
