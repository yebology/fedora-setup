#!/bin/bash
# =============================================================================
# Set Ghostty font + transparency (Linux)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/ghostty-linux.sh)
# =============================================================================

mkdir -p ~/.config/ghostty

cat > ~/.config/ghostty/config << 'EOF'
# Font
font-family = JetBrainsMono Nerd Font
font-size = 14

# Theme
theme = GitHub Dark Default

# Transparency
background-opacity = 0.85
background-blur-radius = 20

# Shell
command = /bin/zsh

# Window
window-padding-x = 10
window-padding-y = 10
EOF

echo "✅ Done! Restart Ghostty."
echo "   Adjust background-opacity (0.0 - 1.0) for more/less transparency."
