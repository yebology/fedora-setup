#!/bin/bash
# =============================================================================
# Fix fastfetch color on Ghostty (p10k instant prompt conflict)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

# Clean all previous fastfetch attempts from .zshrc
sed -i '/fastfetch/d' ~/.zshrc
sed -i '/FASTFETCH_DONE/d' ~/.zshrc
sed -i '/export TERM=xterm/d' ~/.zshrc
sed -i '/precmd/d' ~/.zshrc

# Put fastfetch at the VERY FIRST line of .zshrc (before p10k instant prompt)
sed -i '1i\fastfetch' ~/.zshrc

echo "✅ Done! Close ALL Ghostty windows and reopen."
