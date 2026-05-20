#!/bin/bash
# =============================================================================
# Install and enable Dash to Dock on Fedora 42 (GNOME 48)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/install-dock.sh)
# =============================================================================

echo "Installing Dash to Dock..."

# Install the extension
sudo dnf install -y gnome-shell-extension-dash-to-dock

# Disable version validation (needed for GNOME 48 compatibility)
gsettings set org.gnome.shell disable-extension-version-validation true

# Enable the extension
gnome-extensions enable dash-to-dock@micxgx.gmail.com 2>/dev/null

# Also add to enabled-extensions via gsettings as fallback
CURRENT=$(gsettings get org.gnome.shell enabled-extensions)
if echo "$CURRENT" | grep -q "dash-to-dock"; then
  echo "  Already in enabled-extensions list"
else
  # Add to existing list
  if [ "$CURRENT" = "@as []" ]; then
    gsettings set org.gnome.shell enabled-extensions "['dash-to-dock@micxgx.gmail.com']"
  else
    NEW=$(echo "$CURRENT" | sed "s/]/, 'dash-to-dock@micxgx.gmail.com']/")
    gsettings set org.gnome.shell enabled-extensions "$NEW"
  fi
fi

echo ""
echo "✅ Dash to Dock installed and enabled!"
echo ""
echo "   Log out and log back in (or restart) for dock to appear."
echo ""
echo "   To customize: open Extensions app → Dash to Dock → Settings"
