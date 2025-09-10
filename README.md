#!/data/data/com.termux/files/usr/bin/bash
# OmegaRootX Termux Auto Installer 🚀

echo "🔧 Installing OmegaRootX custom Termux setup..."

# Step 1: Update & install basic packages (git + gh + termux-api added)
pkg update -y && pkg upgrade -y
pkg install -y zsh git gh curl neofetch nano fzf termux-api

# Step 2: Install Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

# Step 3: Copy zshrc from repo (current folder) to $HOME
cp ~/OmegaRootX-Termux/zshrc ~/.zshrc

# Step 4: Install plugins
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-completions" ] && git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
[ ! -d "${ZSH_CUSTOM}/plugins/zsh-autocomplete" ] && git clone --depth=1 https://github.com/marlonrichert/zsh-autocomplete ${ZSH_CUSTOM}/plugins/zsh-autocomplete

# Step 5: Set Zsh as default shell
chsh -s zsh

echo "✅ Setup complete! Please restart Termux or run: exec zsh"
