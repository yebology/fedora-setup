#!/bin/bash
# =============================================================================
# Reset GNOME to Fedora defaults (fonts + theme + icons + cursor)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-gnome-fonts.sh)
# =============================================================================

# Reset fonts
gsettings set org.gnome.desktop.interface font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Source Code Pro 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Cantarell Bold 11'

# Reset theme, icons, cursor
gsettings reset org.gnome.desktop.interface gtk-theme
gsettings reset org.gnome.desktop.interface icon-theme
gsettings reset org.gnome.desktop.interface cursor-theme
gsettings reset org.gnome.desktop.interface color-scheme

echo "✅ Done! GNOME reset to Fedora defaults (fonts + theme + icons + cursor)."
