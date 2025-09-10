#!/data/data/com.termux/files/usr/bin/bash
set -e
echo "🔧 OmegaRootX Installer Starting..."

pkg update -y && pkg upgrade -y
pkg install -y zsh git curl neofetch nano fzf termux-api jq

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
mkdir -p "$ZSH_CUSTOM/plugins"

for repo in \
  https://github.com/zsh-users/zsh-autosuggestions \
  https://github.com/zsh-users/zsh-syntax-highlighting \
  https://github.com/zsh-users/zsh-completions \
  https://github.com/marlonrichert/zsh-autocomplete; do
  NAME=$(basename "$repo")
  DEST="$ZSH_CUSTOM/plugins/$NAME"
  if [ ! -d "$DEST" ]; then
    git clone --depth=1 "$repo" "$DEST"
  fi
done

cp -a "/sdcard/OmegaRootX/zshrc" "$HOME/.zshrc"

rm -f ~/.zcompdump* 2>/dev/null || true
chsh -s zsh || true

echo "✅ Installer finished. Run: exec zsh"
