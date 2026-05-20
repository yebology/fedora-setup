#!/bin/bash
# =============================================================================
# Reset GNOME fonts to Fedora defaults (after KDE override)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-gnome-fonts.sh)
# =============================================================================

gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 11'

echo "✅ Done! GNOME fonts reset to Fedora defaults."
