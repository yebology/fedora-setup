#!/bin/bash
# =============================================================================
# Set Ghostty config clean (GitHub Dark Default theme)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-theme.sh)
# =============================================================================

mkdir -p ~/.config/ghostty

cat > ~/.config/ghostty/config << 'EOF'
font-family = MesloLGS NF
command = /bin/zsh
theme = GitHub Dark Default
EOF

echo "✅ Done! Restart Ghostty."
echo "   If theme not found, run: ghostty +list-themes | grep -i github"
