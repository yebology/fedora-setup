#!/bin/bash
# =============================================================================
# Reset .zshrc from scratch (fresh Oh My Zsh + p10k + fastfetch)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-zshrc.sh)
# =============================================================================

# Backup broken .zshrc
cp ~/.zshrc ~/.zshrc.broken

# Regenerate fresh .zshrc from Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set Powerlevel10k theme
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Add fastfetch at line 1
sed -i '1i\fastfetch' ~/.zshrc

# Add p10k source at end
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

echo "✅ Done! .zshrc regenerated fresh."
echo "   Old broken file saved as ~/.zshrc.broken"
echo "   Restart Ghostty now."
