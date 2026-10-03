#!/bin/bash
# =============================================================================
# Create clean .zshrc from scratch (no Oh My Zsh reinstall needed)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-zshrc.sh)
# =============================================================================

cat > ~/.zshrc << 'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Run fastfetch last, after the shell and prompt theme are fully loaded,
# so terminal color support is initialized and the logo/text render in color.
fastfetch
EOF

echo "✅ Done! Restart Ghostty."
