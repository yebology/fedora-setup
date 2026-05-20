#!/bin/bash
# =============================================================================
# Fedora Fresh Install Setup Script
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/setup.sh)
# =============================================================================

set -e

echo "=========================================="
echo "  Fedora Dev Setup - Starting..."
echo "=========================================="

# ---------------------------------------------------------------------------
# 1. System Update
# ---------------------------------------------------------------------------
echo "[1/15] Updating system..."
sudo dnf update -y

# ---------------------------------------------------------------------------
# 2. RPM Fusion + Multimedia Codecs
# ---------------------------------------------------------------------------
echo "[2/15] Adding RPM Fusion repos + codecs..."
sudo dnf install -y \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf group install -y multimedia
sudo dnf install -y ffmpeg ffmpeg-libs

# ---------------------------------------------------------------------------
# 3. Flathub
# ---------------------------------------------------------------------------
echo "[3/15] Enabling Flathub..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# ---------------------------------------------------------------------------
# 4. Brave Browser
# ---------------------------------------------------------------------------
echo "[4/15] Installing Brave Browser..."
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install -y brave-browser

# ---------------------------------------------------------------------------
# 5. Ghostty Terminal
# ---------------------------------------------------------------------------
echo "[5/15] Installing Ghostty..."
sudo dnf copr enable -y pgdev/ghostty
sudo dnf install -y ghostty

# ---------------------------------------------------------------------------
# 6. Zsh + Oh My Zsh + Powerlevel10k
# ---------------------------------------------------------------------------
echo "[6/15] Installing Zsh + Oh My Zsh + Powerlevel10k..."
sudo dnf install -y zsh util-linux-user

# Install Oh My Zsh (unattended)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# Set Powerlevel10k as theme
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc

# Change default shell to Zsh
chsh -s $(which zsh)

# ---------------------------------------------------------------------------
# 7. Fonts (Nerd Font for Powerlevel10k + coding)
# ---------------------------------------------------------------------------
echo "[7/15] Installing fonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
curl -fLO https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
sudo dnf install -y jetbrains-mono-fonts-all
fc-cache -fv
cd ~

# ---------------------------------------------------------------------------
# 8. Git Setup
# ---------------------------------------------------------------------------
echo "[8/15] Installing Git..."
sudo dnf install -y git git-credential-libsecret

# ---------------------------------------------------------------------------
# 9. Node.js via nvm
# ---------------------------------------------------------------------------
echo "[9/15] Installing Node.js via nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts
nvm use --lts

# ---------------------------------------------------------------------------
# 10. Python + pip + uv
# ---------------------------------------------------------------------------
echo "[10/15] Installing Python + uv..."
sudo dnf install -y python3 python3-pip python3-devel
curl -LsSf https://astral.sh/uv/install.sh | sh

# ---------------------------------------------------------------------------
# 11. Docker + Docker Compose
# ---------------------------------------------------------------------------
echo "[11/15] Installing Docker..."
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER

# ---------------------------------------------------------------------------
# 12. Rust + Cargo
# ---------------------------------------------------------------------------
echo "[12/15] Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

# ---------------------------------------------------------------------------
# 13. Kiro
# ---------------------------------------------------------------------------
echo "[13/15] Kiro..."
echo "  >> Download manually: https://kiro.dev/downloads"
echo "  >> Install: sudo dnf install ./kiro-*.rpm"

# ---------------------------------------------------------------------------
# 14. Telegram
# ---------------------------------------------------------------------------
echo "[14/15] Installing Telegram..."
flatpak install -y flathub org.telegram.desktop

# ---------------------------------------------------------------------------
# 15. GNOME Tweaks + Utilities
# ---------------------------------------------------------------------------
echo "[15/15] Installing utilities..."
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
  ssh-keygen -t ed25519 -C "$ssh_email" -f ~/.ssh/id_ed25519 -N ""
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_ed25519
  echo ""
  echo "  >> Your public SSH key (add to GitHub):"
  cat ~/.ssh/id_ed25519.pub
  echo ""
fi

# ---------------------------------------------------------------------------
# Done!
# ---------------------------------------------------------------------------
echo ""
echo "=========================================="
echo "  Setup Complete!"
echo "=========================================="
echo ""
echo "  Next steps:"
echo "  1. Reboot (for Docker group + Zsh to take effect)"
echo "  2. Open Ghostty -> Powerlevel10k config wizard will start"
echo "  3. Set Ghostty font to 'MesloLGS NF'"
echo "  4. Download & install Kiro from https://kiro.dev/downloads"
echo "  5. git config --global user.name \"Your Name\""
echo "  6. git config --global user.email \"your@email.com\""
echo "  7. Add SSH key to GitHub: https://github.com/settings/keys"
echo ""
read -p "  Reboot now? (y/n) " r
[ "$r" = "y" ] && sudo reboot
