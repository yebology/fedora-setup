#!/bin/bash
# =============================================================================
# Install JetBrainsMono Nerd Font and set as Ghostty font
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/install-font.sh)
# =============================================================================

echo "Installing JetBrainsMono Nerd Font..."

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip -d JetBrainsMono
rm -f JetBrainsMono.zip
fc-cache -fv
cd ~

# Update Ghostty config
sed -i 's/font-family = .*/font-family = JetBrainsMono Nerd Font/' ~/.config/ghostty/config

echo ""
echo "✅ Done! Restart Ghostty to use JetBrainsMono Nerd Font."
