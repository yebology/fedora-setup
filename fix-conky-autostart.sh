#!/bin/bash
# =============================================================================
# Fix Conky autostart using systemd (works on Wayland)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-conky-autostart.sh)
# =============================================================================

# Remove old .desktop autostart if exists
rm -f ~/.config/autostart/conky.desktop

# Create systemd user service
mkdir -p ~/.config/systemd/user
cat > ~/.config/systemd/user/conky.service << 'EOF'
[Unit]
Description=Conky Desktop Clock
After=graphical-session.target

[Service]
ExecStartPre=/bin/sleep 3
ExecStart=/usr/bin/conky
Restart=on-failure
RestartSec=3

[Install]
WantedBy=graphical-session.target
EOF

# Enable and start
systemctl --user daemon-reload
systemctl --user enable conky.service
systemctl --user start conky.service

echo "✅ Done! Conky will auto-start on every login."
echo "   Logout and login to verify."
