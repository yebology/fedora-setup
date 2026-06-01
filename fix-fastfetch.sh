#!/bin/bash
# =============================================================================
# Fastfetch config - full info + color palette
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

mkdir -p ~/.config/fastfetch

cat > ~/.config/fastfetch/config.jsonc << 'EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
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

echo "✅ Done! Restart Ghostty to see full info + color palette."
