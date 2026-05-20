#!/bin/bash
# =============================================================================
# Fix .zshrc parse error (orphan fi)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/fix-zshrc.sh)
# =============================================================================

# Remove any orphan fi (with or without leading whitespace)
sed -i '/^[[:space:]]*fi[[:space:]]*$/d' ~/.zshrc

echo "✅ Done! Restart Ghostty."
