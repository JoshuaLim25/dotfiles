# [[ POWERLEVEL10K INSTANT PROMPT ]] {{
# NOTE: should stay close to the top of ~/.zshrc.
# NOTE: initialization code that may REQUIRE CONSOLE INPUT (password prompts, [y/n]
# confirmations, etc.) MUST GO ABOVE this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# if [[ -f "/opt/homebrew/bin/brew" ]] then
#   # If you're using macOS, you'll want this enabled
#   eval "$(/opt/homebrew/bin/brew shellenv)"
# fi
# Hacky fix I was using to get rid of error message
# typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
# }}

# Rustup tab completions
fpath+=~/.zfunc

# Directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Check for Zinit
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/load Zinit
source "${ZINIT_HOME}/zinit.zsh"

# [[ NVIM = DEFAULT EDITOR ]]
export EDITOR="$(which nvim)"
export VISUAL="$(which nvim)"
export FCEDIT="$(which nvim)"
export MANPAGER='nvim +Man!'
 
# [[ EXPORTS ]] {{
# NOTE: you want to define that directory to the path variable, not the actual binary:
# EG: `PATH=$MYDIR:$PATH`, where MYDIR is def as the dir containing your binary
# NOTE: ORDER MATTERS. For `LHS:RHS,` LHS is the prepended head, RHS is the appended tail

# NOTE: symlinked to ~/.dotfiles/scripts
export PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.local/bin/scripts

# BAT COLOR
export BAT_THEME="ansi"

# TODO: diff bw this and what's in ./.zshenv?
# export PATH="$HOME/.cargo/bin:$PATH"

# TODO: python path edition
# export PYTHONPATH="`pwd`:$PYTHONPATH"
# }}

# [[ ADDITIONAL ZINIT/PROMPT CONFIGURATION ]] {{
zinit ice depth=1; zinit light romkatv/powerlevel10k # Add Powerlevel10k
# NOTE: to customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# [[ ZSH PLUGINS ]]
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light kutsan/zsh-system-clipboard

# [[ SNIPPETS ]]
# Don't use, but could be worth looking at
# `rm -rf .local/share/zinit/snippets`
# zinit snippet OMZP::git
# zinit snippet OMZP::sudo
# zinit snippet OMZP::archlinux
# zinit snippet OMZP::aws
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::kubectx
# zinit snippet OMZP::command-not-found

autoload -Uz compinit && compinit # Load completions
zinit cdreplay -q # Replay cached completions (recommended)
# }}

# [[ HISTORY ]] {{
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
# }}

# [[ STYLING COMPLETIONS ]] {{
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# }}

# [[ CUSTOM SCRIPTS ]] {{
# Keybindings
source ~/.dotfiles/scripts/set-vi-mode.sh
# SSH
source ~/.dotfiles/scripts/ssh.sh
# Fish-like abbrevations/expansions
source ~/.dotfiles/scripts/abbrev-alias.sh
# See ~/.config/systemd/user/ssh-agent.service
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
# }}

# [[ HELPER FUNCTIONS ]] {{
# # https://stackoverflow.com/questions/1314334/easy-way-to-create-a-file-nested-in-unavailable-directories/1314345#1314345
# mktouch {
#   mkdir -p "$(dirname $1)"
#   touch "$1"
# }
# # https://superuser.com/questions/1412808/add-function-to-zsh
# docker-clean() {
#   docker stop "$(docker ps -a -q)"
#   docker rm "$(docker ps -a -q)"
#   docker rmi "$(docker images -q)"
#   docker volume prune
# }
# }}

# [[ ABBREVIATIONS ]] {{
# [[ ESSENTIAL ]]
abbrev-alias v='nvim'
abbrev-alias getmeout="shutdown -h now"
abbrev-alias za="zathura"
abbrev-alias minitree="tree -aL 3 --prune"

# [[ QUICK NAVIGATION ]]
abbrev-alias cdracket="cd ~/Documents/cis-352/autograder-assignments/"
abbrev-alias cdsystems="cd ~/Documents/cis-384/"
abbrev-alias cdtest="cd ~/spaghetti/test/"
abbrev-alias cdnotes="cd ~/Documents/ObsidianNotes/"
abbrev-alias cdgit="cd ~/Documents/git_testing/"
abbrev-alias cdrs="cd ~/spaghetti/langs/rust/testing_grounds/"

# [[ PROJECT-SPECIFIC ]]
abbrev-alias cdip="cd ~/research-projects/seed-emulator/examples/internet/B28_traffic_generator/0-iperf-traffic-generator"
abbrev-alias cdlogs="cd /home/josh/research-projects/seed-emulator/examples/internet/B28_traffic_generator/0-iperf-traffic-generator/logs"
abbrev-alias cdbug="cd ~/repos/buildkit/control/gateway/"
abbrev-alias s="source development.env && source seedenv/bin/activate"
abbrev-alias lsout='ls ./output | wc -l'

# [[ GIT ]]
abbrev-alias g="git "
abbrev-alias gs="git status"
abbrev-alias ga="git add"
abbrev-alias gaa="git add ."
abbrev-alias gc="git commit"
abbrev-alias gp="git push"
abbrev-alias gd="git diff"
abbrev-alias gl="git log --oneline --graph --decorate"
abbrev-alias gll="git log --graph --decorate"
abbrev-alias gr="git restore --staged"
abbrev-alias gra="git restore --staged ."
abbrev-alias gcls="git clone git@github.com:"

# [[ DOCKER ]]
abbrev-alias dc="docker compose"
abbrev-alias dcbuild="docker compose build"
abbrev-alias dcup="docker compose up"
# See https://docs.docker.com/reference/cli/docker/compose/up/ for more
abbrev-alias dcups="docker compose up --remove-orphans --abort-on-container-failure"

# [[ RUST ]]
abbrev-alias clipme='
cargo clippy -- \
-W clippy::pedantic \
-W clippy::nursery \
-W clippy::unwrap_used \
'

# [[ TMUX ]] {{
abbrev-alias t="tmux"
abbrev-alias tnew="tmux new -s"

# [[ ALIASES ]] {{
# [[ SHELL ]]
alias c='clear'
alias ls='ls --color'
alias ll='ls -lh --color'
alias cat='bat'
alias rm='rm -I' # safety
alias mv='mv -i' # safety
alias grep='rg'
# alias vim='nvim'
alias ip='ip --color=auto'
alias echopath='echo $PATH | tr ":" "\n"'

# [[ "QOL" ]]
alias vdiff='nvim -d'
alias py='python3'
alias pd='pushd'
alias todo='nvim ~/misc/TODO.md'
alias hk='nvim ~/misc/hotkeys.md'
alias remind='nvim ~/misc/reminders.md'
alias qq='nvim ~/misc/blooms.md'
alias sc='shellcheck'
# https://www.reddit.com/r/golang/comments/uzrbw3/best_practice_do_you_use_the_go_compiler_from/
alias goupdate='sudo rm -rf /usr/local/go && curl -L https://go.dev/dl/go1.18.2.linux-amd64.tar.gz | sudo tar zx -C /usr/local/ go'
alias btconnect='bluetoothctl connect BC:87:FA:BB:97:66'
alias souniq='sort | uniq -c'
alias e='exercism'
# }}

# [[ REFERENCES ]] {{
# [[ LANGUAGES ]]
alias refbash="nvim ~/spaghetti/langs/bash/bashics.sh"
alias bbash="nvim ~/spaghetti/langs/bash/bad_bash.sh"
alias refcpp="nvim ~/spaghetti/langs/c++/ref.md"
alias refrust="nvim ~/spaghetti/langs/rust/reference-code/help.rs"
# [[ TOOLS ]]
alias refvm="nvim ~/spaghetti/tools/vm-ref.md"
alias refjson="nvim ~/spaghetti/tools/json.md"
alias refcron="nvim ~/spaghetti/tools/cron.sh"
alias refmake="nvim ~/spaghetti/tools/Makefile"
alias refdocker="nvim ~/spaghetti/tools/docker-ref.md"
alias refgit="nvim ~/spaghetti/tools/git.md"
alias refvim="nvim ~/spaghetti/tools/vim.md"
# }}

# [[ SHELL INTEGRATIONS ]] {{
eval "$(fzf --zsh)"
# eval "$(zoxide init --cmd cd zsh)"
# }}
