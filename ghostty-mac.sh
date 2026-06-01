#!/bin/bash
# =============================================================================
# Set Ghostty font + transparency (macOS)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/ghostty-mac.sh)
# =============================================================================

CONFIG="$HOME/Library/Application Support/com.mitchellh.ghostty/config"

cat > "$CONFIG" << 'EOF'
# Font
font-family = JetBrainsMono Nerd Font
font-size = 14

# Theme
theme = GitHub Dark Default

# Transparency
background-opacity = 0.85
background-blur-radius = 20

# Window
macos-titlebar-style = hidden
window-padding-x = 10
window-padding-y = 10
EOF

echo "✅ Done! Restart Ghostty."
echo "   Adjust background-opacity (0.0 - 1.0) for more/less transparency."
