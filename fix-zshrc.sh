#!/bin/bash
# =============================================================================
# Nuclear reset .zshrc (delete and regenerate)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-zshrc.sh)
# =============================================================================

# Delete broken .zshrc completely
rm -f ~/.zshrc

# Regenerate fresh from Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set Powerlevel10k theme
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Add fastfetch at line 1
sed -i '1i\fastfetch' ~/.zshrc

# Add p10k source at end
echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc

echo "✅ Done! Restart Ghostty."
