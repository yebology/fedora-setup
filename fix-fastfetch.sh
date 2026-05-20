#!/bin/bash
# =============================================================================
# Fix fastfetch color + clean broken .zshrc
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

# Remove broken if/fi blocks from previous attempts
sed -i '/^if \[\[ -z \$FASTFETCH_DONE/,/^fi$/d' ~/.zshrc

# Clean all fastfetch related lines
sed -i '/fastfetch/d' ~/.zshrc
sed -i '/FASTFETCH_DONE/d' ~/.zshrc
sed -i '/export TERM=xterm/d' ~/.zshrc
sed -i '/TERM=xterm/d' ~/.zshrc
sed -i '/precmd/d' ~/.zshrc

# Put fastfetch at line 1 (before p10k instant prompt)
sed -i '1i\fastfetch' ~/.zshrc

echo "✅ Done! Close ALL Ghostty windows and reopen."
