#!/bin/bash
# =============================================================================
# Install Dash to Dock (macOS-like dock for GNOME)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/install-dock.sh)
# =============================================================================

echo "Installing Dash to Dock..."

# Install the extension
sudo dnf install -y gnome-shell-extension-dash-to-dock

# Enable the extension
gnome-extensions enable dash-to-dock@micxgx.gmail.com 2>/dev/null

echo ""
echo "✅ Dash to Dock installed!"
echo ""
echo "   If dock doesn't appear immediately:"
echo "   1. Log out and log back in"
echo "   2. Or press Alt+F2, type 'r', press Enter (restarts GNOME Shell)"
echo ""
echo "   To customize (position, size, auto-hide):"
echo "   Open 'Extensions' app → Dash to Dock → Settings"
