#!/bin/bash
# =============================================================================
# Install Dash to Dock (macOS-like dock for GNOME)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/install-dock.sh)
# =============================================================================

echo "Installing Dash to Dock..."

# Try dnf first
if sudo dnf install -y gnome-shell-extension-dash-to-dock 2>/dev/null; then
  echo "✅ Installed via dnf"
else
  echo "dnf failed, trying manual install..."
  # Manual install from GitHub
  mkdir -p /tmp/dash-to-dock
  cd /tmp/dash-to-dock
  git clone --depth=1 https://github.com/micheleg/dash-to-dock.git .
  make
  make install
  cd ~
  rm -rf /tmp/dash-to-dock
  echo "✅ Installed from source"
fi

# Enable the extension
gnome-extensions enable dash-to-dock@micxgx.gmail.com 2>/dev/null || true

echo ""
echo "✅ Done!"
echo "   If dock doesn't appear, logout and login again."
echo "   Then run: gnome-extensions enable dash-to-dock@micxgx.gmail.com"
