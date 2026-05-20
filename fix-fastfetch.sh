#!/bin/bash
# =============================================================================
# Fix fastfetch color on Ghostty startup (attempt 2)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

# Remove broken config if exists
rm -f ~/.config/fastfetch/config.jsonc

# Set Ghostty to use xterm-256color
mkdir -p ~/.config/ghostty
if ! grep -q "^term = " ~/.config/ghostty/config 2>/dev/null; then
  echo "term = xterm-256color" >> ~/.config/ghostty/config
else
  sed -i 's/^term = .*/term = xterm-256color/' ~/.config/ghostty/config
fi

# Clean all fastfetch lines from .zshrc
sed -i '/fastfetch/d' ~/.zshrc
sed -i '/TERM=xterm/d' ~/.zshrc

# Add fastfetch at end of .zshrc (simple, no flags)
echo 'fastfetch' >> ~/.zshrc

echo "✅ Done! Close ALL Ghostty windows and reopen."
echo "   If still white, run: echo \$TERM"
echo "   and share the output."
