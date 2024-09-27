# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# if [[ -f "/opt/homebrew/bin/brew" ]] then
#   # If you're using macOS, you'll want this enabled
#   eval "$(/opt/homebrew/bin/brew shellenv)"
# fi

# for rustup tab completions
fpath+=~/.zfunc

# Hacky fix to get rid of error message
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Setting nvim as default editor
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
export MANPAGER='nvim +Man!'
 
# shouldn't need this, but in case
# export PATH="$HOME/.cargo/bin:$PATH"

# Note: you want to define that directory to the path variable, not the actual binary e.g.
# PATH=$MYDIR:$PATH
# where MYDIR is defined as the directory containing your binary e.g.
# PATH=/Users/username/bin:$PATH
# NOTE: Order matters, the example above prepends, switch to append

# Symlinked to ~/.dotfiles/scripts
export PATH=$PATH:~/.local/bin/scripts

# bat color
export BAT_THEME="ansi"

# Python path edition
# export PYTHONPATH="`pwd`:$PYTHONPATH"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light kutsan/zsh-system-clipboard

# Add in snippets
# Don't even use these, could be useful though
# `rm -rf .local/share/zinit/snippets`
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

# Used to replay cached completions, recommended
zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
source ~/.dotfiles/scripts/set-vi-mode.sh

# SSH
source ~/.dotfiles/scripts/ssh.sh
# See ~/.config/systemd/user/ssh-agent.service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Abbreviations
source ~/.dotfiles/scripts/abbrev-alias.sh
abbrev-alias cat='bat'
abbrev-alias v='nvim'
abbrev-alias getmeout="shutdown -h now"

# Quick Navigation
abbrev-alias cdracket="cd ~/Documents/cis-352/autograder-assignments/"
abbrev-alias cdsystems="cd ~/Documents/cis-384/"
abbrev-alias cdtest="cd ~/spaghetti/test/"
abbrev-alias cdnotes="cd ~/Documents/ObsidianNotes/"
abbrev-alias cdgit="cd ~/Documents/git-playground/"
# Project-specific
abbrev-alias cdip="cd ~/research-projects/seed-emulator/examples/internet/B28_traffic_generator/0-iperf-traffic-generator"
abbrev-alias cdlogs="cd ~/research-projects/iperf3-logs/"
abbrev-alias cdbug="cd ~/buildkit/control/gateway/"
abbrev-alias s="source development.env && source seedenv/bin/activate"


## Git
abbrev-alias g="git "
abbrev-alias gs="git status"
abbrev-alias ga="git add"
abbrev-alias gaa="git add ."
abbrev-alias gc="git commit"
abbrev-alias gp="git push"
abbrev-alias gd="git diff"
abbrev-alias gl="git log --oneline --graph --decorate"
abbrev-alias gr="git restore --staged"
abbrev-alias gra="git restore --staged ."

## Docker
abbrev-alias dc="docker-compose"
abbrev-alias dcbuild="docker-compose build"
abbrev-alias dcup="docker-compose up"
abbrev-alias za="zathura"

# Aliases
# Shell
alias c='clear'
alias ls='ls --color'
alias ll='ls -lh --color'
alias rm='rm -I' # safety
alias mv='mv -I' # safety
alias grep='rg'
alias vim='nvim'
alias ip='ip --color=auto'

# "QOL"
alias vimdiff='nvim -d'
alias py='python3'
alias pd='pushd'
alias todo='nvim ~/TODO.md'

# References
alias refbash="nvim ~/spaghetti/langs/bash/bashics.sh"
alias refcron="nvim ~/spaghetti/tools/cron.sh"
alias refmake="nvim ~/spaghetti/tools/Makefile"
alias refdocker="nvim ~/spaghetti/tools/docker-ref.md"

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"
