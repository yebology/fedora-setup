#!/bin/bash
# =============================================================================
# Verify all installations from setup.sh
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/verify.sh)
# =============================================================================

echo "=========================================="
echo "  Verifying installations..."
echo "=========================================="
echo ""

PASS=0
FAIL=0

check_cmd() {
  if command -v "$2" &>/dev/null; then
    echo "  ✅ $1"
    ((PASS++))
  else
    echo "  ❌ $1 — NOT FOUND"
    ((FAIL++))
  fi
}

check_flatpak() {
  if flatpak list 2>/dev/null | grep -qi "$2"; then
    echo "  ✅ $1"
    ((PASS++))
  else
    echo "  ❌ $1 — NOT FOUND"
    ((FAIL++))
  fi
}

check_dir() {
  if [ -d "$2" ]; then
    echo "  ✅ $1"
    ((PASS++))
  else
    echo "  ❌ $1 — NOT FOUND"
    ((FAIL++))
  fi
}

echo "--- System Tools ---"
check_cmd "Git" "git"
check_cmd "Make" "make"
check_cmd "GCC" "gcc"
check_cmd "curl" "curl"
check_cmd "wget" "wget"
check_cmd "htop" "htop"
check_cmd "neofetch" "neofetch"
check_cmd "Flameshot" "flameshot"

echo ""
echo "--- Shell ---"
check_cmd "Zsh" "zsh"
check_dir "Oh My Zsh" "$HOME/.oh-my-zsh"
check_dir "Powerlevel10k" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo ""
echo "--- Development ---"

# Node.js (needs nvm loaded)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
check_cmd "Node.js" "node"
check_cmd "npm" "npm"
check_dir "nvm" "$HOME/.nvm"

check_cmd "Python3" "python3"
check_cmd "pip" "pip3"
check_cmd "Docker" "docker"
check_cmd "Rust (cargo)" "cargo"
check_cmd "Ghostty" "ghostty"

# uv
if [ -f "$HOME/.local/bin/uv" ] || command -v uv &>/dev/null; then
  echo "  ✅ uv (Python package manager)"
  ((PASS++))
else
  echo "  ❌ uv — NOT FOUND"
  ((FAIL++))
fi

# Kiro
if command -v kiro &>/dev/null || [ -d "/opt/kiro" ] || [ -d "$HOME/.local/share/kiro" ]; then
  echo "  ✅ Kiro IDE"
  ((PASS++))
else
  echo "  ❌ Kiro IDE — NOT FOUND"
  ((FAIL++))
fi

echo ""
echo "--- Browsers ---"
check_cmd "Brave Browser" "brave-browser"

echo ""
echo "--- Apps (Flatpak) ---"
check_flatpak "Telegram" "telegram"
check_flatpak "WhatsApp (ZapZap)" "zapzap"
check_flatpak "Beekeeper Studio" "beekeeperstudio"
check_flatpak "Bruno" "bruno"
check_flatpak "Spotify" "spotify"

echo ""
echo "--- Fonts ---"
if fc-list | grep -qi "MesloLGS"; then
  echo "  ✅ MesloLGS Nerd Font"
  ((PASS++))
else
  echo "  ❌ MesloLGS Nerd Font — NOT FOUND"
  ((FAIL++))
fi

if fc-list | grep -qi "JetBrains Mono"; then
  echo "  ✅ JetBrains Mono"
  ((PASS++))
else
  echo "  ❌ JetBrains Mono — NOT FOUND"
  ((FAIL++))
fi

echo ""
echo "--- Repos ---"
if dnf repolist 2>/dev/null | grep -qi "rpmfusion"; then
  echo "  ✅ RPM Fusion"
  ((PASS++))
else
  echo "  ❌ RPM Fusion — NOT FOUND"
  ((FAIL++))
fi

if flatpak remotes 2>/dev/null | grep -qi "flathub"; then
  echo "  ✅ Flathub"
  ((PASS++))
else
  echo "  ❌ Flathub — NOT FOUND"
  ((FAIL++))
fi

echo ""
echo "=========================================="
echo "  Results: $PASS passed, $FAIL failed"
echo "=========================================="

if [ $FAIL -eq 0 ]; then
  echo "  🎉 All good! Everything installed correctly."
else
  echo "  ⚠️  Some items failed. Re-run setup.sh or install manually."
fi
