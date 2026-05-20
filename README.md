# Fedora Setup

One command to set up a fresh Fedora installation with all development tools.

## Usage

Open terminal after fresh Fedora install and run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/setup.sh)
```

## What's Included

| Category | Tools |
|----------|-------|
| Browser | Brave |
| Terminal | Ghostty + Zsh + Oh My Zsh + Powerlevel10k |
| Fonts | MesloLGS Nerd Font + JetBrains Mono |
| JavaScript | Node.js (LTS via nvm) |
| Python | Python 3 + pip + uv |
| Rust | Rust + Cargo (via rustup) |
| Containers | Docker + Docker Compose |
| Editor | Kiro (manual download) |
| Chat | Telegram (Flatpak) |
| Utilities | Git, Make, GCC, htop, neofetch, Flameshot, GNOME Tweaks |
| Repos | RPM Fusion + Flathub |
| Media | FFmpeg + multimedia codecs |

## After Setup

1. Reboot
2. Open Ghostty → Powerlevel10k wizard starts automatically
3. Set Ghostty font to `MesloLGS NF`
4. Download & install [Kiro](https://kiro.dev/downloads) `.rpm`
5. Configure git name/email
6. Add SSH key to [GitHub](https://github.com/settings/keys)
