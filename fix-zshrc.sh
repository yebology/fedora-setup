#!/bin/bash
# =============================================================================
# Create clean .zshrc from scratch (no Oh My Zsh reinstall needed)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-zshrc.sh)
# =============================================================================

cat > ~/.zshrc << 'EOF'
fastfetch

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git)
source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
EOF

echo "✅ Done! Restart Ghostty."
