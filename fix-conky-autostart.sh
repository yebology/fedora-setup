#!/bin/bash
# =============================================================================
# Fix Conky autostart on login
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-conky-autostart.sh)
# =============================================================================

mkdir -p ~/.config/autostart

cat > ~/.config/autostart/conky.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Conky
Exec=bash -c "sleep 5 && conky"
StartupNotify=false
Terminal=false
X-GNOME-Autostart-enabled=true
EOF

echo "✅ Done! Conky will auto-start 5 seconds after login."
echo "   Logout and login to test."
