#!/bin/bash
# =============================================================================
# Fully remove KDE Plasma and restore GNOME as default
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/remove-kde.sh)
# =============================================================================

echo "=========================================="
echo "  Removing KDE Plasma..."
echo "=========================================="

# Remove KDE group
sudo dnf remove -y @kde-desktop-environment 2>/dev/null || true

# Remove remaining KDE/Plasma/Qt packages
sudo dnf remove -y "plasma*" "kf5*" "kf6*" "kde*" --exclude="kde-filesystem" 2>/dev/null || true

# Remove orphaned dependencies
sudo dnf autoremove -y

# Remove KDE config files
rm -rf ~/.config/kde* ~/.config/plasma* ~/.config/kwin* ~/.config/kscreen*
rm -rf ~/.local/share/kde* ~/.local/share/plasma* ~/.local/share/kscreen*
rm -rf ~/.cache/plasma* ~/.cache/kde*

# Switch back to GDM (GNOME login manager)
sudo systemctl disable sddm 2>/dev/null || true
sudo systemctl enable gdm 2>/dev/null || true

# Reset GNOME to defaults
dconf reset -f /org/gnome/

# Re-enable Dash to Dock
gsettings set org.gnome.shell disable-extension-version-validation true
gnome-extensions enable dash-to-dock@micxgx.gmail.com 2>/dev/null || true

echo ""
echo "=========================================="
echo "  ✅ KDE removed! GNOME restored."
echo "=========================================="
echo ""
echo "  Rebooting in 5 seconds..."
sleep 5
sudo reboot
