#!/bin/bash
# =============================================================================
# Fix .zshrc broken p10k source line
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-zshrc.sh)
# =============================================================================

# Remove broken p10k source line(s)
sed -i '/^\[\[.*p10k/d' ~/.zshrc

# Add correct p10k source line at end
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

echo "✅ Done! Restart Ghostty."
