#!/bin/bash
# =============================================================================
# Fedora Fresh Install Setup Script
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/setup.sh)
# =============================================================================

# Don't use set -e — we want the script to continue even if one step fails
ERRORS=()

echo "=========================================="
echo "  Fedora Dev Setup - Starting..."
echo "=========================================="

# ---------------------------------------------------------------------------
# 1. System Update
# ---------------------------------------------------------------------------
echo "[1/18] Updating system..."
sudo dnf update -y || ERRORS+=("System Update")

# ---------------------------------------------------------------------------
# 2. RPM Fusion + Multimedia Codecs
# ---------------------------------------------------------------------------
echo "[2/18] Adding RPM Fusion repos + codecs..."
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm || ERRORS+=("RPM Fusion")

sudo dnf group install -y multimedia || ERRORS+=("Multimedia codecs")
sudo dnf install -y ffmpeg ffmpeg-libs || ERRORS+=("FFmpeg")

# ---------------------------------------------------------------------------
# 3. Flathub
# ---------------------------------------------------------------------------
echo "[3/18] Enabling Flathub..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo || ERRORS+=("Flathub")

# ---------------------------------------------------------------------------
# 4. Brave Browser
# ---------------------------------------------------------------------------
echo "[4/18] Installing Brave Browser..."
sudo dnf install -y dnf-plugins-core || true
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo || true
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc || true
sudo dnf install -y brave-browser || ERRORS+=("Brave Browser")

# ---------------------------------------------------------------------------
# 5. Ghostty Terminal
# ---------------------------------------------------------------------------
echo "[5/18] Installing Ghostty..."
sudo dnf copr enable -y pgdev/ghostty || true
sudo dnf install -y ghostty || ERRORS+=("Ghostty")

# ---------------------------------------------------------------------------
# 6. Zsh + Oh My Zsh + Powerlevel10k
# ---------------------------------------------------------------------------
echo "[6/18] Installing Zsh + Oh My Zsh + Powerlevel10k..."
sudo dnf install -y zsh util-linux-user || ERRORS+=("Zsh")

# Install Oh My Zsh (unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || ERRORS+=("Oh My Zsh")
fi

# Install Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" || ERRORS+=("Powerlevel10k")
fi

# Set Powerlevel10k as theme
if [ -f ~/.zshrc ]; then
  sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
fi

# Change default shell to Zsh
chsh -s $(which zsh) || ERRORS+=("Change shell to Zsh")

# ---------------------------------------------------------------------------
# 7. Fonts (Nerd Font for Powerlevel10k + coding)
# ---------------------------------------------------------------------------
echo "[7/18] Installing fonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf || true
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf || true
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf || true
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf || true
sudo dnf install -y jetbrains-mono-fonts-all || true
fc-cache -fv
cd ~

# ---------------------------------------------------------------------------
# 8. Git Setup
# ---------------------------------------------------------------------------
echo "[8/18] Installing Git..."
sudo dnf install -y git git-credential-libsecret || ERRORS+=("Git")

# ---------------------------------------------------------------------------
# 9. Node.js via nvm
# ---------------------------------------------------------------------------
echo "[9/18] Installing Node.js via nvm..."
if [ ! -d "$HOME/.nvm" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash || ERRORS+=("nvm")
fi
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts || ERRORS+=("Node.js LTS")
nvm use --lts || true

# ---------------------------------------------------------------------------
# 10. Python + pip + uv
# ---------------------------------------------------------------------------
echo "[10/18] Installing Python + uv..."
sudo dnf install -y python3 python3-pip python3-devel || ERRORS+=("Python")
curl -LsSf https://astral.sh/uv/install.sh | sh || ERRORS+=("uv")

# ---------------------------------------------------------------------------
# 11. Docker + Docker Compose
# ---------------------------------------------------------------------------
echo "[11/18] Installing Docker..."
sudo dnf -y install dnf-plugins-core || true
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo || true
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || ERRORS+=("Docker")
sudo systemctl start docker || true
sudo systemctl enable docker || true
sudo usermod -aG docker $USER || true

# ---------------------------------------------------------------------------
# 12. Rust + Cargo
# ---------------------------------------------------------------------------
echo "[12/18] Installing Rust..."
if ! command -v cargo &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || ERRORS+=("Rust")
  source "$HOME/.cargo/env" || true
fi

# ---------------------------------------------------------------------------
# 13. Kiro IDE
# ---------------------------------------------------------------------------
echo "[13/18] Installing Kiro IDE..."
curl -fsSL https://raw.githubusercontent.com/abhilashiig/kiro-ide-linux-installation/main/clone-and-install-kiro.sh | bash || ERRORS+=("Kiro IDE")

# ---------------------------------------------------------------------------
# 14. Telegram + WhatsApp
# ---------------------------------------------------------------------------
echo "[14/18] Installing Telegram + WhatsApp..."
flatpak install -y flathub org.telegram.desktop || ERRORS+=("Telegram")
flatpak install -y flathub com.rtosta.zapzap || ERRORS+=("WhatsApp/ZapZap")

# ---------------------------------------------------------------------------
# 15. Beekeeper Studio (Database GUI)
# ---------------------------------------------------------------------------
echo "[15/18] Installing Beekeeper Studio..."
flatpak install -y flathub io.beekeeperstudio.Studio || ERRORS+=("Beekeeper Studio")

# ---------------------------------------------------------------------------
# 16. Bruno (API Client)
# ---------------------------------------------------------------------------
echo "[16/18] Installing Bruno..."
flatpak install -y flathub com.usebruno.Bruno || ERRORS+=("Bruno")

# ---------------------------------------------------------------------------
# 17. Spotify
# ---------------------------------------------------------------------------
echo "[17/18] Installing Spotify..."
flatpak install -y flathub com.spotify.Client || ERRORS+=("Spotify")

# ---------------------------------------------------------------------------
# 18. GNOME Tweaks + Utilities
# ---------------------------------------------------------------------------
echo "[18/18] Installing utilities..."
sudo dnf install -y \
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
  openssl-devel || ERRORS+=("Utilities")

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
  for err in "${ERRORS[@]}"; do
    echo "     ❌ $err"
  done
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
