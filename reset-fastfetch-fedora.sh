#!/bin/bash
# =============================================================================
# Force-reset fastfetch config to Fedora logo (writes directly, no curl pipe)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/reset-fastfetch-fedora.sh)
# =============================================================================

echo "=========================================="
echo "  Resetting fastfetch config to Fedora logo"
echo "=========================================="

CONFIG_PATH="$HOME/.config/fastfetch/config.jsonc"

echo ""
echo "--- Before ---"
if [ -L "$CONFIG_PATH" ]; then
  echo "⚠️  $CONFIG_PATH is a symlink pointing to: $(readlink -f "$CONFIG_PATH")"
fi
if [ -f "$CONFIG_PATH" ]; then
  cat "$CONFIG_PATH"
else
  echo "(no existing config)"
fi

# Remove any existing file or symlink to guarantee a clean overwrite
rm -f "$CONFIG_PATH"

mkdir -p ~/.config/fastfetch
cat > "$CONFIG_PATH" << 'EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "source": "fedora",
    "padding": {
      "top": 1,
      "left": 2,
      "right": 4
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
echo "--- After ---"
cat "$CONFIG_PATH"

echo ""
echo "✅ Done! Config forcefully rewritten with Fedora logo."
echo "   Restart Ghostty completely (close all windows, reopen) to see the change."
echo ""
echo "   If the logo still doesn't change, run: fastfetch --logo fedora"
echo "   to confirm fastfetch itself can render it correctly."
