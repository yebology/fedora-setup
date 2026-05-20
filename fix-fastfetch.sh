#!/bin/bash
# =============================================================================
# Fix fastfetch logo color + simplify .zshrc
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-fastfetch.sh)
# =============================================================================

# Create fastfetch config with blue Fedora logo
mkdir -p ~/.config/fastfetch
cat > ~/.config/fastfetch/config.jsonc << 'EOF'
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "logo": {
    "source": "fedora",
    "color": {
      "1": "blue",
      "2": "white"
    }
  }
}
EOF

# Simplify .zshrc — remove flags, just call fastfetch
sed -i 's/fastfetch.*/fastfetch/' ~/.zshrc

echo "✅ Done! Restart Ghostty to see blue Fedora logo."
