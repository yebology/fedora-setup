#!/bin/bash
# =============================================================================
# Fix fastfetch color on Ghostty startup
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

# Remove broken config if exists
rm -f ~/.config/fastfetch/config.jsonc

# Clean all fastfetch lines from .zshrc
sed -i '/fastfetch/d' ~/.zshrc
sed -i '/TERM=xterm/d' ~/.zshrc

# Add fastfetch with forced color support at end of .zshrc
echo 'TERM=xterm-256color fastfetch' >> ~/.zshrc

echo "✅ Done! Close ALL Ghostty windows and reopen."
