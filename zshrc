# ===== OmegaRootX Custom Zshrc =====
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

autoload -Uz compinit && compinit
setopt PROMPT_SUBST
autoload -U colors && colors

# ---------- Helper function ----------
show_status() {
  if command -v termux-battery-status >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    bat_pct=$(termux-battery-status | jq -r '.percentage // "N/A"')
    bat_stat=$(termux-battery-status | jq -r '.status // ""')
    bat_txt="${bat_pct}% (${bat_stat})"
  else
    bat_txt="NoTermuxAPI"
  fi

  if df -h "$HOME/storage/shared" >/dev/null 2>&1; then
    storage_line=$(df -h "$HOME/storage/shared" | awk 'NR==2{print $3"/"$2 " (" $5 ")"}')
  else
    storage_line=$(df -h ~ | awk 'NR==1{print $3"/"$2 " (" $5 ")"}')
  fi

  if command -v free >/dev/null 2>&1; then
    mem_line=$(free -h | awk 'NR==2{print $3"/"$2}')
  else
    mem_line="N/A"
  fi

  echo "Battery: $bat_txt | Storage: $storage_line | Mem: $mem_line"
}

cat <<'BANNER'
   ____  _           _   ____            _
  / __ \(_)___  ____| | / __ )___  _____(_)___ ___
 / / / / / __ \/ __ `/ / __  / _ \/ ___/ / __ `__ \
/ /_/ / / / / / /_/ / / /_/ /  __/ /  / / / / / / /
\____/_/_/ /_/\__,_/_/_____/ \___/_/  /_/_/ /_/ /_/
              OmegaRootX
BANNER

if command -v neofetch >/dev/null 2>&1; then
  neofetch --disable title --disable underline
fi
show_status

PROMPT=$'🐱 %F{cyan}OmegaRootX%f %F{yellow}%~%f\n➜ '
