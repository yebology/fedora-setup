#!/bin/bash
# =============================================================================
# Hide clock from GNOME top bar (since Conky shows it on desktop)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/hide-topbar-clock.sh)
# =============================================================================

# Hide date and weekday from top bar
gsettings set org.gnome.desktop.interface clock-show-date false
gsettings set org.gnome.desktop.interface clock-show-weekday false

# Install Just Perfection extension to fully hide clock
sudo dnf install -y gnome-shell-extension-just-perfection 2>/dev/null

# Enable version validation bypass
gsettings set org.gnome.shell disable-extension-version-validation true

# Enable Just Perfection
gnome-extensions enable just-perfection-desktop@just-perfection 2>/dev/null

# Hide clock via Just Perfection settings
gsettings set org.gnome.shell.extensions.just-perfection clock false 2>/dev/null

echo ""
echo "✅ Done! Clock hidden from top bar."
echo ""
echo "   If clock still shows, logout and login again."
echo "   To undo: gsettings set org.gnome.shell.extensions.just-perfection clock true"
