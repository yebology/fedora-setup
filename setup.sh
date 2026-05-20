#!/bin/bash
# =============================================================================
# Fedora Fresh Install Setup Script (Fedora 41+ / dnf5 compatible)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/setup.sh)
# =============================================================================

# Don't use set -e — we want the script to continue even if one step fails
ERRORS=()
LOGFILE="$HOME/fedora-setup.log"

# Log all output to file for debugging
exec > >(tee -a "$LOGFILE") 2>&1

echo "=========================================="
echo "  Fedora Dev Setup - Starting..."
echo "  Log file: $LOGFILE"
echo "=========================================="

# Detect dnf version (dnf5 vs dnf4)
if dnf5 --version &>/dev/null || dnf --version 2>&1 | grep -q "dnf5"; then
  DNF_ADD_REPO="sudo dnf config-manager addrepo --from-repofile="
else
  DNF_ADD_REPO="sudo dnf config-manager --add-repo "
fi
echo "  Using repo command: $DNF_ADD_REPO"

# Helper: run a step and capture error with reason
run_step() {
  local step_name="$1"
  shift
  echo ""
  echo "--- Running: $step_name ---"
  if "$@"; then
    echo "--- ✅ $step_name succeeded ---"
  else
    local exit_code=$?
    echo "--- ❌ $step_name FAILED (exit code: $exit_code) ---"
    ERRORS+=("$step_name (exit code: $exit_code)")
  fi
}

# Helper: run a step using eval (for commands with pipes or variables)
run_step_eval() {
  local step_name="$1"
  shift
  echo ""
  echo "--- Running: $step_name ---"
  if eval "$@"; then
    echo "--- ✅ $step_name succeeded ---"
  else
    local exit_code=$?
    echo "--- ❌ $step_name FAILED (exit code: $exit_code) ---"
    ERRORS+=("$step_name (exit code: $exit_code)")
  fi
}

# ---------------------------------------------------------------------------
# 1. System Update
# ---------------------------------------------------------------------------
echo "[1/18] Updating system..."
run_step "System Update" sudo dnf update -y

# ---------------------------------------------------------------------------
# 2. RPM Fusion + Multimedia Codecs
# ---------------------------------------------------------------------------
echo "[2/18] Adding RPM Fusion repos + codecs..."
run_step "RPM Fusion Free" sudo dnf install -y "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
run_step "RPM Fusion Nonfree" sudo dnf install -y "https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"
run_step "Multimedia codecs" sudo dnf group install -y multimedia
run_step "FFmpeg" sudo dnf install -y ffmpeg ffmpeg-libs

# ---------------------------------------------------------------------------
# 3. Flathub
# ---------------------------------------------------------------------------
echo "[3/18] Enabling Flathub..."
run_step "Flathub" flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# ---------------------------------------------------------------------------
# 4. Brave Browser
# ---------------------------------------------------------------------------
echo "[4/18] Installing Brave Browser..."
sudo dnf install -y dnf-plugins-core 2>/dev/null || true
run_step_eval "Brave repo" "${DNF_ADD_REPO}https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo"
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc 2>/dev/null || true
run_step "Brave Browser" sudo dnf install -y brave-browser

# ---------------------------------------------------------------------------
# 5. Ghostty Terminal
# ---------------------------------------------------------------------------
echo "[5/18] Installing Ghostty..."
sudo dnf copr enable -y pgdev/ghostty 2>/dev/null || true
run_step "Ghostty" sudo dnf install -y ghostty

# ---------------------------------------------------------------------------
# 6. Zsh + Oh My Zsh + Powerlevel10k
# ---------------------------------------------------------------------------
echo "[6/18] Installing Zsh + Oh My Zsh + Powerlevel10k..."
run_step "Zsh" sudo dnf install -y zsh util-linux-user

# Install Oh My Zsh (unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  run_step_eval "Oh My Zsh" 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
fi

# Install Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  run_step "Powerlevel10k" git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Set Powerlevel10k as theme
if [ -f ~/.zshrc ]; then
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
fi

# Change default shell to Zsh
chsh -s "$(which zsh)" 2>/dev/null || ERRORS+=("Change shell to Zsh — run manually: chsh -s \$(which zsh)")

# ---------------------------------------------------------------------------
# 7. Fonts (Nerd Font for Powerlevel10k + coding)
# ---------------------------------------------------------------------------
echo "[7/18] Installing fonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf 2>/dev/null || ERRORS+=("Font: MesloLGS Regular")
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf 2>/dev/null || true
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf 2>/dev/null || true
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf 2>/dev/null || true
run_step "JetBrains Mono font" sudo dnf install -y jetbrains-mono-fonts-all
fc-cache -fv 2>/dev/null
cd ~

# ---------------------------------------------------------------------------
# 8. Git Setup
# ---------------------------------------------------------------------------
echo "[8/18] Installing Git..."
run_step "Git" sudo dnf install -y git git-credential-libsecret

# ---------------------------------------------------------------------------
# 9. Node.js via nvm
# ---------------------------------------------------------------------------
echo "[9/18] Installing Node.js via nvm..."
if [ ! -d "$HOME/.nvm" ]; then
  run_step_eval "nvm" 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
if command -v nvm &>/dev/null; then
  run_step "Node.js LTS" nvm install --lts
  nvm use --lts 2>/dev/null || true
else
  ERRORS+=("Node.js — nvm not loaded, restart terminal and run: nvm install --lts")
fi

# ---------------------------------------------------------------------------
# 10. Python + pip + uv
# ---------------------------------------------------------------------------
echo "[10/18] Installing Python + uv..."
run_step "Python" sudo dnf install -y python3 python3-pip python3-devel
run_step_eval "uv" 'curl -LsSf https://astral.sh/uv/install.sh | sh'

# ---------------------------------------------------------------------------
# 11. Docker + Docker Compose
# ---------------------------------------------------------------------------
echo "[11/18] Installing Docker..."
sudo dnf -y install dnf-plugins-core 2>/dev/null || true
run_step_eval "Docker repo" "${DNF_ADD_REPO}https://download.docker.com/linux/fedora/docker-ce.repo"
run_step "Docker" sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker 2>/dev/null || true
sudo systemctl enable docker 2>/dev/null || true
sudo usermod -aG docker "$USER" 2>/dev/null || true

# ---------------------------------------------------------------------------
# 12. Rust + Cargo
# ---------------------------------------------------------------------------
echo "[12/18] Installing Rust..."
if ! command -v cargo &>/dev/null; then
  run_step_eval "Rust" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
  [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
fi

# ---------------------------------------------------------------------------
# 13. Kiro IDE
# ---------------------------------------------------------------------------
echo "[13/18] Installing Kiro IDE..."
run_step_eval "Kiro IDE" 'curl -fsSL https://raw.githubusercontent.com/abhilashiig/kiro-ide-linux-installation/main/clone-and-install-kiro.sh | bash'

# ---------------------------------------------------------------------------
# 14. Telegram + WhatsApp
# ---------------------------------------------------------------------------
echo "[14/18] Installing Telegram + WhatsApp..."
run_step "Telegram" flatpak install -y flathub org.telegram.desktop
run_step "WhatsApp (ZapZap)" flatpak install -y flathub com.rtosta.zapzap

# ---------------------------------------------------------------------------
# 15. Beekeeper Studio (Database GUI)
# ---------------------------------------------------------------------------
echo "[15/18] Installing Beekeeper Studio..."
run_step "Beekeeper Studio" flatpak install -y flathub io.beekeeperstudio.Studio

# ---------------------------------------------------------------------------
# 16. Bruno (API Client)
# ---------------------------------------------------------------------------
echo "[16/18] Installing Bruno..."
run_step "Bruno" flatpak install -y flathub com.usebruno.Bruno

# ---------------------------------------------------------------------------
# 17. Spotify
# ---------------------------------------------------------------------------
echo "[17/18] Installing Spotify..."
run_step "Spotify" flatpak install -y flathub com.spotify.Client

# ---------------------------------------------------------------------------
# 18. GNOME Tweaks + Utilities
# ---------------------------------------------------------------------------
echo "[18/18] Installing utilities..."
run_step "Utilities" sudo dnf install -y \
  gnome-tweaks \
  flameshot \
  htop \
  neofetch \
  unzip \
  curl \
  wget \
  make \
  gcc \
  gcc-c++ \
  openssl-devel

# ---------------------------------------------------------------------------
# SSH Key Generation
# ---------------------------------------------------------------------------
echo ""
echo "=========================================="
echo "  Generate SSH key for GitHub?"
echo "=========================================="
read -p "Enter email for SSH key (Enter to skip): " ssh_email
if [ -n "$ssh_email" ]; then
  mkdir -p ~/.ssh
  ssh-keygen -t ed25519 -C "$ssh_email" -f ~/.ssh/id_ed25519 -N ""
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  echo ""
  echo "  >> Your public SSH key (add to GitHub):"
  cat ~/.ssh/id_ed25519.pub
  echo ""
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo ""
echo "=========================================="
if [ ${#ERRORS[@]} -eq 0 ]; then
  echo "  ✅ Setup Complete! All steps succeeded."
else
  echo "  ⚠️  Setup Complete with ${#ERRORS[@]} error(s):"
  echo ""
  for err in "${ERRORS[@]}"; do
    echo "     ❌ $err"
  done
  echo ""
  echo "  Full log saved at: $LOGFILE"
  echo "  Review errors: grep -B2 -A5 'FAILED' $LOGFILE"
fi
echo "=========================================="
echo ""
echo "  Next steps:"
echo "  1. Reboot (for Docker group + Zsh to take effect)"
echo "  2. Open Ghostty -> Powerlevel10k config wizard will start"
echo "  3. Set Ghostty font to 'MesloLGS NF'"
echo "  4. git config --global user.name \"Your Name\""
echo "  5. git config --global user.email \"your@email.com\""
echo "  6. Add SSH key to GitHub: https://github.com/settings/keys"
echo ""
read -p "  Reboot now? (y/n) " r
[ "$r" = "y" ] && sudo reboot
