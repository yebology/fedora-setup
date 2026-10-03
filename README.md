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
| Editor | VS Code |
| Terminal | Ghostty + Zsh + Oh My Zsh + Powerlevel10k |
| Fonts | MesloLGS Nerd Font + JetBrains Mono |
| JavaScript | Node.js (LTS via nvm) |
| AI Coding | Claude Code CLI + 9 official plugins (github, frontend-design, superpowers, code-review, context7, skill-creator, code-simplifier, claude-md-management, feature-dev) + 3 third-party plugins (headroom, ponytail, claude-mem) |
| Python | Python 3 + pip + uv |
| Rust | Rust + Cargo (via rustup) |
| Solidity | Foundry (forge, cast, anvil, chisel) |
| Containers | Docker + Docker Compose |
| Chat | Telegram (Flatpak) |
| Notes | Obsidian (Flatpak) |
| Music | Spotify (Flatpak) |
| Utilities | Git, Make, GCC, htop, neofetch, Flameshot, GNOME Tweaks |
| Repos | RPM Fusion + Flathub |
| Media | FFmpeg + multimedia codecs |

## After Setup

1. Reboot
2. Open Ghostty → Powerlevel10k wizard starts automatically
3. Set Ghostty font to `MesloLGS NF`
4. Configure git name/email
5. Add SSH key to [GitHub](https://github.com/settings/keys)
6. (Optional) Download & install [Kiro](https://kiro.dev/downloads) `.rpm`
