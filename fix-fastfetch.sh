#!/bin/bash
# =============================================================================
# Minimal fastfetch config (clean, simple)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

mkdir -p ~/.config/fastfetch

cat > ~/.config/fastfetch/config.jsonc << 'EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "source": "fedora",
    "padding": {
      "top": 1
    }
  },
  "modules": [
    "title",
    "separator",
    "os",
    "kernel",
    "shell",
    "terminal",
    "cpu",
    "memory",
    "disk",
    "battery"
  ]
}
EOF

echo "✅ Done! Restart Ghostty or run 'fastfetch' to see."
