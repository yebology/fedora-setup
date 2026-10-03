#!/bin/bash
# =============================================================================
# Set fastfetch logo + text color to purple
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/set-fastfetch-purple.sh)
# =============================================================================

echo "=========================================="
echo "  Setting fastfetch color to purple"
echo "=========================================="

CONFIG_PATH="$HOME/.config/fastfetch/config.jsonc"

# Remove any existing file or symlink to guarantee a clean overwrite
rm -f "$CONFIG_PATH"

mkdir -p ~/.config/fastfetch
cat > "$CONFIG_PATH" << 'EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "source": "fedora",
    "color": {
      "1": "magenta",
      "2": "magenta"
    },
    "padding": {
      "top": 1,
      "left": 2,
      "right": 4
    }
  },
  "display": {
    "color": {
      "keys": "magenta",
      "title": "magenta"
    }
  },
  "modules": [
    "title",
    "separator",
    "os",
    "host",
    "kernel",
    "uptime",
    "packages",
    "shell",
    "display",
    "cpu",
    "gpu",
    "memory",
    "disk",
    "localip",
    "battery",
    "separator",
    "colors"
  ]
}
EOF

echo ""
echo "--- Config written ---"
cat "$CONFIG_PATH"

echo ""
echo "✅ Done! Logo and text set to purple (magenta)."
echo "   Restart Ghostty completely (close all windows, reopen) to see the change."
echo ""
echo "   If the color still doesn't apply, run 'tput colors' — it must show"
echo "   256 or higher. If it shows less, Ghostty's TERM isn't set correctly."
