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
export EDITOR='nvim'
export VISUAL='nvim'
export MANPAGER='nvim +Man!'
 
# shouldn't need this, but in case
# export PATH="$HOME/.cargo/bin:$PATH"

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

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e # emacs mode
# bindkey '^f' autosuggest-accept
# this is set by default by emacs
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

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
source ~/.abbrev-alias.sh
abbrev-alias cat='bat'
abbrev-alias v='nvim'
abbrev-alias rm="rm -I" # safety with rm
abbrev-alias getmeout="shutdown -h now"
abbrev-alias cdracket="cd ~/Documents/cis-352/autograder-assignments/"
abbrev-alias cdsystems="cd ~/Documents/cis-384/"
abbrev-alias cdtest="cd ~/spaghetti/test/"
abbrev-alias cdnotes="cd ~/Documents/ObsidianNotes/"
abbrev-alias fman="whence -c -m '*' | fzf | xargs man"

## Git
abbrev-alias gs="git status"
abbrev-alias ga="git add"
abbrev-alias gaa="git add ."
abbrev-alias gc="git commit"
abbrev-alias gp="git push"
abbrev-alias gd="git diff"
abbrev-alias gr="git restore --staged"
abbrev-alias gra="git restore --staged ."

## Docker
abbrev-alias dc="docker-compose"
abbrev-alias dcbuild="docker-compose build"
abbrev-alias dcup="docker-compose up"

# Aliases
alias c='clear'
alias ls='ls --color'
alias ll='ls -lh --color'
alias grep='rg'
alias vim='nvim'

# Shell integrations
eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"


