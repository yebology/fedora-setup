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

check() {
  if command -v "$2" &>/dev/null || flatpak list 2>/dev/null | grep -qi "$2" || [ -d "$2" ]; then
    echo -e "  ✅ $1"
    ((PASS++))
  else
    echo -e "  ❌ $1 — NOT FOUND"
    ((FAIL++))
  fi
}

check_flatpak() {
  if flatpak list 2>/dev/null | grep -qi "$2"; then
    echo -e "  ✅ $1"
    ((PASS++))
  else
    echo -e "  ❌ $1 — NOT FOUND"
    ((FAIL++))
  fi
}

check_dir() {
  if [ -d "$2" ]; then
    echo -e "  ✅ $1"
    ((PASS++))
  else
    echo -e "  ❌ $1 — NOT FOUND"
    ((FAIL++))
  fi
}

echo "--- System Tools ---"
check "Git" "git"
check "Make" "make"
check "GCC" "gcc"
check "curl" "curl"
check "wget" "wget"
check "htop" "htop"
check "neofetch" "neofetch"
check "Flameshot" "flameshot"

echo ""
echo "--- Shell ---"
check "Zsh" "zsh"
check_dir "Oh My Zsh" "$HOME/.oh-my-zsh"
check_dir "Powerlevel10k" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

echo ""
echo "--- Development ---"
check "Node.js" "node"
check "npm" "npm"
check "Python3" "python3"
check "pip" "pip3"
check "Docker" "docker"
check "Docker Compose" "docker"
check "Rust (cargo)" "cargo"
check "Ghostty" "ghostty"

# Check uv
if [ -f "$HOME/.cargo/bin/uv" ] || command -v uv &>/dev/null; then
  echo -e "  ✅ uv (Python package manager)"
  ((PASS++))
else
  echo -e "  ❌ uv — NOT FOUND"
  ((FAIL++))
fi

# Check nvm
if [ -d "$HOME/.nvm" ]; then
  echo -e "  ✅ nvm"
  ((PASS++))
else
  echo -e "  ❌ nvm — NOT FOUND"
  ((FAIL++))
fi

echo ""
echo "--- Browsers ---"
check "Brave Browser" "brave-browser"

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
  echo -e "  ✅ MesloLGS Nerd Font"
  ((PASS++))
else
  echo -e "  ❌ MesloLGS Nerd Font — NOT FOUND"
  ((FAIL++))
fi

if fc-list | grep -qi "JetBrains Mono"; then
  echo -e "  ✅ JetBrains Mono"
  ((PASS++))
else
  echo -e "  ❌ JetBrains Mono — NOT FOUND"
  ((FAIL++))
fi

echo ""
echo "--- Repos ---"
if dnf repolist 2>/dev/null | grep -qi "rpmfusion"; then
  echo -e "  ✅ RPM Fusion"
  ((PASS++))
else
  echo -e "  ❌ RPM Fusion — NOT FOUND"
  ((FAIL++))
fi

if flatpak remotes 2>/dev/null | grep -qi "flathub"; then
  echo -e "  ✅ Flathub"
  ((PASS++))
else
  echo -e "  ❌ Flathub — NOT FOUND"
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
