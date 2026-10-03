#!/bin/bash
# =============================================================================
# Install all VS Code extensions (synced from a local machine's install list)
# Usage: bash <(curl -fsSL https://raw.githubusercontent.com/yebology/fedora-setup/main/install-vscode-extensions.sh)
# =============================================================================

echo "=========================================="
echo "  Installing VS Code extensions..."
echo "=========================================="

if ! command -v code &>/dev/null; then
  echo "❌ 'code' CLI not found. Install VS Code first (see setup.sh step 5)."
  exit 1
fi

ERRORS=()

EXTENSIONS=(
  ackeeblockchain.tools-for-solidity
  akamud.vscode-theme-onedark
  alexcvzz.vscode-sqlite
  anthropic.claude-code
  ayushh.vscode-anchor
  batisteo.vscode-django
  bradlc.vscode-tailwindcss
  burkeholland.simple-react-snippets
  christian-kohler.npm-intellisense
  cweijan.vscode-office
  dfinity-foundation.vscode-motoko
  docker.docker
  donjayamanne.python-environment-manager
  donjayamanne.python-extension-pack
  dracula-theme.theme-dracula
  dsznajder.es7-react-js-snippets
  dustypomerleau.rust-syntax
  eamodio.gitlens
  ecmel.vscode-html-css
  esbenp.prettier-vscode
  exodiusstudios.comment-anchors
  file-icons.file-icons
  formulahendry.auto-close-tag
  formulahendry.auto-complete-tag
  formulahendry.auto-rename-tag
  formulahendry.code-runner
  fwcd.kotlin
  github.github-vscode-theme
  github.vscode-github-actions
  golang.go
  graphql.vscode-graphql
  graphql.vscode-graphql-syntax
  hosho.solidity-debugger
  illixion.vscode-vibrancy-continued
  jebbs.plantuml
  jeroen-meijer.pubspec-assist
  kevinrose.vsc-python-indent
  mathiasfrohlich.kotlin
  mgesbert.python-path
  mgmcdermott.vscode-language-babel
  mohdzaid.kiro-theme
  motoko-lsp-client.motoko-lsp-client
  mquandalle.graphql
  ms-azuretools.vscode-containers
  ms-azuretools.vscode-docker
  ms-kubernetes-tools.vscode-kubernetes-tools
  ms-python.debugpy
  ms-python.python
  ms-python.vscode-pylance
  ms-python.vscode-python-envs
  ms-toolsai.jupyter
  ms-toolsai.jupyter-keymap
  ms-toolsai.jupyter-renderers
  ms-toolsai.vscode-jupyter-cell-tags
  ms-toolsai.vscode-jupyter-slideshow
  ms-vscode.makefile-tools
  ms-vscode.vscode-typescript-next
  natizyskunk.sftp
  njpwerner.autodocstring
  nomicfoundation.hardhat-solidity
  oracle.oracle-java
  patriciobcs.solana-snippets
  pkief.material-icon-theme
  prisma.prisma
  prisma.prisma-insider
  qwtel.sqlite-viewer
  redhat.java
  redhat.vscode-yaml
  rust-lang.rust-analyzer
  shahilkumar.docxreader
  sidthesloth.html5-boilerplate
  sixth.sixth-ai
  solang.solang
  sonarsource.sonarlint-vscode
  tamasfe.even-better-toml
  tintinweb.graphviz-interactive-preview
  tintinweb.solidity-visual-auditor
  tintinweb.vscode-ethover
  tintinweb.vscode-inline-bookmarks
  tintinweb.vscode-solidity-flattener
  tintinweb.vscode-solidity-language
  tomoki1207.pdf
  tushortz.python-extended-snippets
  vscjava.migrate-java-to-azure
  vscjava.vscode-gradle
  vscjava.vscode-java-debug
  vscjava.vscode-java-dependency
  vscjava.vscode-java-pack
  vscjava.vscode-java-test
  vscjava.vscode-maven
  wholroyd.jinja
  xabikos.javascriptsnippets
  zhuangtongfa.material-theme
  zignd.html-css-class-completion
)

TOTAL=${#EXTENSIONS[@]}
COUNT=0

for ext in "${EXTENSIONS[@]}"; do
  COUNT=$((COUNT + 1))
  echo ""
  echo "[$COUNT/$TOTAL] Installing: $ext"
  if code --install-extension "$ext" --force; then
    echo "✅ $ext"
  else
    echo "❌ $ext FAILED"
    ERRORS+=("$ext")
  fi
done

echo ""
echo "=========================================="
if [ ${#ERRORS[@]} -eq 0 ]; then
  echo "  ✅ All $TOTAL extensions installed successfully!"
else
  echo "  ⚠️  Installed with ${#ERRORS[@]} error(s):"
  for err in "${ERRORS[@]}"; do
    echo "     ❌ $err"
  done
fi
echo "=========================================="
