#!/bin/bash
# =============================================================================
# Move GNOME top bar clock/date to the right (via Just Perfection)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/move-clock-right.sh)
# =============================================================================

echo "=========================================="
echo "  Moving top bar clock to the right..."
echo "=========================================="

# Install Just Perfection if not already present
if ! rpm -q gnome-shell-extension-just-perfection &>/dev/null; then
  echo "Installing Just Perfection..."
  sudo dnf install -y gnome-shell-extension-just-perfection
fi

# Bypass version validation (needed on newer GNOME Shell)
gsettings set org.gnome.shell disable-extension-version-validation true

# Enable the extension
gnome-extensions enable just-perfection-desktop@just-perfection 2>/dev/null

# Move the clock menu to the right side of the top bar
gsettings set org.gnome.shell.extensions.just-perfection clock-menu-position 2
gsettings set org.gnome.shell.extensions.just-perfection clock-menu-position-offset 0

echo ""
echo "✅ Done! Clock should now appear on the right side of the top bar."
echo ""
echo "   If it didn't move, open the Extensions app → Just Perfection →"
echo "   Panel section, and set 'Date Menu Position' to 'Right' manually."
echo ""
echo "   If the clock still doesn't show at all, logout and login again."
echo "   To revert to center: gsettings set org.gnome.shell.extensions.just-perfection clock-menu-position 1"
