if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

ZSH_COLORIZE_TOOL=pygmentize

plugins=(git sudo python colorize copypath copyfile)
source $ZSH/oh-my-zsh.sh

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(zoxide init zsh)"
source <(fzf --zsh)

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Created by `pipx` on 2026-05-11 18:28:06
export PATH="$PATH:/home/ardsimm/.local/bin"

alias greet="python3 /home/ardsimm/.config/zsh/welcome.py"
greet
# ========== ENV Variables ==========
#
# ---------- nvim ----------
export USER="smenard"
export MAIL="smenard@student.42lyon.fr"

# ----- Directories -----
# dev
DEV_DIR="~/dev"
SCRIPTS_DIR="$DEV_DIR/scripts"

# ft
FT_DIR="$DEV_DIR/ft"
COMMON_CORE_DIR="$FT_DIR/common_core"
MS_0_DIR="$COMMON_CORE_DIR/ms-0"
MS_1_DIR="$COMMON_CORE_DIR/ms-1"
MS_2_DIR="$COMMON_CORE_DIR/ms-2"
MS_3_DIR="$COMMON_CORE_DIR/ms-3"
CODEXION_DIR="$MS_3_DIR/codexion"

# ========== ALIASES ==========
#
# ---------- Git ----------
# Addig & Commiting
alias ga="git add"
alias gaa="git add ."
alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit --amend"
# Pushing & Pulling
alias gpl="git pull"
alias gps="git push"
alias gpsf="git push -f"
alias gpsu="git push -u"
alias gpsuom="git push -u origin master"

# Restore
alias grest="git restore"
alias gresta="git restore ."

# Other
alias gs="git status"

# ----- GOTO -----
alias gotodev="cd $DEV_DIR"
alias gotoscripts="cd $SCRIPTS_DIR"
alias gotoft="cd $FT_DIR"
alias gotoms0="cd $MS_0_DIR"
alias gotoms1="cd $MS_1_DIR"
alias gotoms2="cd $MS_2_DIR"
alias gotoms3="cd $MS_3_DIR"
alias gotocdx="cd $CODEXION_DIR"

# ---------- zshrc ----------
alias reload="clear && source ~/.zshrc"
alias editconf="nvim ~/.zshrc && reload"
alias edithyprconf="sudo nvim ~/.config/hypr/hyprland.conf"

# ---------- Package installation ----------#
alias pinstall="sudo pacman -Sy"
alias premove="sudo pacman -Ry"
alias yinstall="yay -Sy"
alias yremove="yay -Ry"

# ---------- Development tools -----------

# Python
alias pnorm="python3 -m flake8"
alias plint="python3 -m mypy --strict ."
alias pformat="black"

# C
alias cformat="c_formatter_42 **/*.c **/*.h"
alias cnorm="norminette"
alias vg="valgrind --leak-check=full -s --show-mismatched-frees=yes --track-origins=yes --show-leak-kinds=all"
