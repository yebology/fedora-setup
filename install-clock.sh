#!/bin/bash
# =============================================================================
# Install Conky with centered clock on desktop
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/install-clock.sh)
# =============================================================================

# Install conky
sudo dnf install -y conky

# Create conky config
mkdir -p ~/.config/conky
cat > ~/.config/conky/conky.conf << 'EOF'
conky.config = {
    alignment = 'middle_middle',
    background = true,
    double_buffer = true,
    own_window = true,
    own_window_type = 'desktop',
    own_window_transparent = true,
    own_window_argb_visual = true,
    own_window_hints = 'undecorated,below,sticky,skip_taskbar,skip_pager',
    use_xft = true,
    font = 'Cantarell:size=12',
    update_interval = 1,
    minimum_width = 400,
    minimum_height = 200,
    border_width = 0,
    draw_shades = false,
    default_color = 'white',
    color1 = 'ffffff',
    color2 = 'aaaaaa',
};

conky.text = [[
${alignc}${font Cantarell:bold:size=60}${color1}${time %H:%M}${font}
${alignc}${font Cantarell:size=18}${color2}${time %A, %d %B %Y}${font}
]];
EOF

# Create autostart entry so conky starts on login
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/conky.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Conky
Exec=conky --daemonize --pause=3
StartupNotify=false
Terminal=false
EOF

# Start conky now
conky --daemonize --pause=1 2>/dev/null

echo "✅ Done! Clock widget now showing on desktop."
echo "   It will auto-start on every login."
echo "   Edit ~/.config/conky/conky.conf to customize."
