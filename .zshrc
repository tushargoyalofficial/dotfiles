# ============================================================================
# ZSH Configuration File - Enhanced
# ============================================================================

# Early exit for non-interactive shells
[[ $- != *i* ]] && return

# ============================================================================
# ENVIRONMENT VARIABLES
# ============================================================================

# XDG Base Directory Specification
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_STATE_HOME="${HOME}/.local/state"

# Editor configuration
export EDITOR="nvim"
export VISUAL="nvim"

# Language and locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Security: Don't store sensitive commands in history
export HISTIGNORE="*sudo -S*:*password*:*passwd*:*token*:*key*:*secret*"

# Better defaults for common tools
export LESS="-R -F -X -i -M -W -z-4"    # Better less defaults
export GREP_OPTIONS="--color=auto"      # Colorize grep output
export MANPAGER="nvim +Man!"            # Use nvim for man pages

# ============================================================================
# PATH CONFIGURATION
# ============================================================================

# Function to safely add to PATH
add_to_path() {
    case ":$PATH:" in
        *":$1:"*) ;;
        *) PATH="$1:$PATH" ;;
    esac
}

# Local binaries
add_to_path "$HOME/.local/bin"

# Development Tools
DEV_TOOLS="$HOME/DevTools"
JAVA_HOME="$DEV_TOOLS/JDK/jdk-21.0.7+6"
ANDROID_HOME="$DEV_TOOLS/Android/Sdk"

export JAVA_HOME
export ANDROID_HOME

# Java and Android SDK paths
if [[ -d "$JAVA_HOME" ]]; then
    add_to_path "$JAVA_HOME/bin"
fi

if [[ -d "$ANDROID_HOME" ]]; then
    add_to_path "$ANDROID_HOME/cmdline-tools/tools/bin"
    add_to_path "$ANDROID_HOME/platform-tools"
    add_to_path "$ANDROID_HOME/tools"
    add_to_path "$ANDROID_HOME/emulator"
fi

# Flutter and Dart
if [[ -d "$DEV_TOOLS/flutter" ]]; then
    add_to_path "$DEV_TOOLS/flutter/bin"
    add_to_path "$HOME/.pub-cache/bin"
fi

# GO LANG
if [[ -d "/usr/local/go/bin" ]]; then
    add_to_path "/usr/local/go/bin"
    add_to_path "$HOME/go/bin"
fi

# Rust/Cargo
if [[ -d "$HOME/.cargo/bin" ]]; then
    add_to_path "$HOME/.cargo/bin"
fi

export PATH

# ============================================================================
# ZSH OPTIONS AND SETTINGS
# ============================================================================

# General ZSH options
setopt AUTO_CD              # cd by typing directory name if it's not a command
setopt CORRECT              # Spelling correction for commands
setopt CORRECT_ALL          # Spelling correction for arguments
setopt GLOB_DOTS            # Include dotfiles in globbing
setopt EXTENDED_GLOB        # Extended globbing patterns
setopt NUMERIC_GLOB_SORT    # Sort numerically when globbing
setopt NO_CASE_GLOB         # Case insensitive globbing
setopt RC_EXPAND_PARAM      # Array expansion
setopt NOTIFY               # Report status of background jobs immediately
setopt HASH_LIST_ALL        # Hash everything before completion
setopt COMPLETE_IN_WORD     # Complete from both ends of a word
setopt ALWAYS_TO_END        # Move cursor to the end of a completed word
setopt PATH_DIRS            # Perform path search even on command names with slashes
setopt AUTO_MENU            # Show completion menu on a successive tab press
setopt AUTO_LIST            # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH     # If completed parameter is a directory, add a trailing slash
setopt FLOW_CONTROL         # Enable output flow control via start/stop characters

# ============================================================================
# ZSH HISTORY CONFIGURATION
# ============================================================================

HISTSIZE=50000
HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh_history"
SAVEHIST=$HISTSIZE

# Create history directory if it doesn't exist
[[ ! -d "$(dirname "$HISTFILE")" ]] && mkdir -p "$(dirname "$HISTFILE")"

# History options
setopt EXTENDED_HISTORY         # Write the history file in the ':start:elapsed;command' format
setopt SHARE_HISTORY            # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming history
setopt HIST_IGNORE_DUPS         # Don't record an entry that was just recorded again
setopt HIST_IGNORE_ALL_DUPS     # Delete old recorded entry if new entry is a duplicate
setopt HIST_FIND_NO_DUPS        # Do not display a line previously found
setopt HIST_IGNORE_SPACE        # Don't record an entry starting with a space
setopt HIST_SAVE_NO_DUPS        # Don't write duplicate entries in the history file
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry
setopt HIST_VERIFY              # Don't execute immediately upon history expansion
setopt HIST_BEEP                # Beep when accessing non-existent history

# ============================================================================
# ZINIT PLUGIN MANAGER SETUP
# ============================================================================

ZINIT_HOME="${XDG_DATA_HOME}/zinit/zinit.git"

# Download ZINIT if it's not there yet
if [[ ! -d "$ZINIT_HOME" ]]; then
    print -P "%F{33}▓▒░ Installing ZINIT (zdharma-continuum/zinit)...%f"
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME" && \
        print -P "%F{34}▓▒░ Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi

# Load zinit
source "$ZINIT_HOME/zinit.zsh"

# ============================================================================
# PLUGINS AND COMPLETIONS
# ============================================================================

# Load essential plugins
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    blockf \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions

# fzf-tab for better tab completion
zinit load Aloxaf/fzf-tab

# Additional useful plugins
zinit wait lucid for \
    atload"zicompinit; zicdreplay" blockf \
        zsh-users/zsh-completions

# Oh-My-Zsh plugins (as snippets)
zinit wait lucid for \
    OMZP::git \
    OMZP::sudo \
    OMZP::command-not-found \
    OMZP::colored-man-pages \
    OMZP::extract

# Conditional Oh-My-Zsh plugins
[[ -f /etc/arch-release ]] && zinit snippet OMZP::archlinux
command -v aws >/dev/null && zinit snippet OMZP::aws
command -v kubectl >/dev/null && zinit snippet OMZP::kubectl
command -v kubectx >/dev/null && zinit snippet OMZP::kubectx
command -v docker >/dev/null && zinit snippet OMZP::docker
command -v docker-compose >/dev/null && zinit snippet OMZP::docker-compose

# ============================================================================
# COMPLETION SYSTEM
# ============================================================================

# Add custom completions to FPATH
fpath=("$HOME/.zsh/completions" $fpath)

# Completion styling
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/.zcompcache"
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'

# Kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Disable sort when completing git checkout
zstyle ':completion:*:git-checkout:*' sort false

# fzf-tab configuration
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 80 12
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1a --color=always $realpath 2>/dev/null || ls -la --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1a --color=always $realpath 2>/dev/null || ls -la --color=always $realpath'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'

# ============================================================================
# KEYBINDINGS
# ============================================================================

# Use emacs key bindings
bindkey -e

# History search
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-search-backward  # Up arrow
bindkey '^[[B' history-search-forward   # Down arrow
bindkey '^r' history-incremental-search-backward
bindkey '^s' history-incremental-search-forward

# Vi mode toggle (jj to enter command mode)
bindkey -M viins 'jj' vi-cmd-mode

# Better word movement
bindkey '^[[1;5C' forward-word          # Ctrl+Right
bindkey '^[[1;5D' backward-word         # Ctrl+Left
bindkey '^[[1;3C' forward-word          # Alt+Right
bindkey '^[[1;3D' backward-word         # Alt+Left

# Delete keys
bindkey '^[[3~' delete-char             # Delete
bindkey '^[[H' beginning-of-line        # Home
bindkey '^[[F' end-of-line              # End

# Additional useful bindings
bindkey '^[[Z' reverse-menu-complete    # Shift+Tab
bindkey '^[^?' backward-kill-word       # Alt+Backspace
bindkey '^[[1;5A' beginning-of-line     # Ctrl+Up
bindkey '^[[1;5B' end-of-line           # Ctrl+Down

# ============================================================================
# ALIASES
# ============================================================================

# Basic commands
alias c='clear'
alias cls='printf "\033c"'  # Complete terminal reset
alias h='history'
alias j='jobs -l'
alias reload='source ~/.zshrc'

# Weather
alias w='weather'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias -- -='cd -'  # Previous directory

# ls and eza (preserving original behavior)
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --color=always --group-directories-first'
    alias ll='eza -l --sort=modified --icons --git --group-directories-first'     # Your original: ls -lt
    alias lla='eza -la --sort=modified --icons --git --group-directories-first'   # Your original: ls -alt
    alias l='eza -l --icons --git -a --group-directories-first'
    alias lt='eza --tree --level=2 --long --icons --git'
    alias ltt='eza --tree --level=4 --long --icons --git'
    alias la='tree'                                                               # Your original: just tree
    alias lta='eza --tree --level=4 --icons -a'
else
    # Fallback to your exact original aliases
    alias ll='ls -lt --color'
    alias lla='ls -alt --color'
    alias la='tree'
    alias ls='ls --color=auto --group-directories-first'
    alias l='ls -l --color=auto'
fi

# Text editors
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias e='$EDITOR'

# File operations
alias cp='cp -i'                                                # Confirm before overwriting
alias mv='mv -i'                                                # Confirm before overwriting
alias rm='rm -i'                                                # Confirm before removing
alias ln='ln -i'                                                # Confirm before overwriting

# Better defaults
alias df='df -h'                                                # Human-readable sizes
alias du='du -h'                                                # Human-readable sizes
alias free='free -h'                                            # Human-readable sizes
alias ps='ps auxf'                                              # Full format listing
alias psg='ps aux | grep -v grep | grep -i -E --color=auto'     # Search processes
alias mkdir='mkdir -pv'                                         # Create parent directories as needed

# Network
alias ping='ping -c 5'
alias ports='netstat -tulanp'
alias myip='curl -s http://ipecho.net/plain; echo'
alias localip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\  -f2"

# System monitoring
alias htop='htop -C'
alias top='htop'
alias mem='free -m -l -t'
alias cpu='grep "cpu " /proc/stat | awk "{usage=(\$2+\$4)*100/(\$2+\$3+\$4+\$5)} END {print usage \"%\"}"'
alias disk='df -h | grep -vE "^Filesystem|tmpfs|cdrom"'

# Safety aliases
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# Better cat
command -v bat >/dev/null 2>&1 && alias cat='bat --paging=never'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add -p'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gc='git commit -m'
alias gca='git commit -a -m'
alias gcam='git commit -am'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gcoall='git checkout -- .'
alias gd='git diff'
alias gdf='git diff'
alias gdca='git diff --cached'
alias gl='git pull origin'
alias gp='git push origin HEAD'
alias gps='git push origin HEAD'
alias gpl='git pull origin'
alias gre='git reset'
alias greh='git reset --hard'
alias grt='git remote'
alias grv='git remote -v'
alias gs='git status'
alias gst='git status'
alias gss='git status -s'
alias glog='git log --graph --topo-order --pretty="%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N" --abbrev-commit'
alias glg='git log --stat'
alias glgg='git log --graph --decorate --oneline'
alias gsh='git show'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gm='git merge'
alias gr='git rebase'
alias gri='git rebase -i'
alias gsta='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'

# Docker aliases
if command -v docker >/dev/null 2>&1; then
    alias d='docker'
    alias dco='docker compose'
    alias dps='docker ps'
    alias dpa='docker ps -a'
    alias dl='docker ps -l -q'
    alias dx='docker exec -it'
    alias dlog='docker logs -f'
    alias dimg='docker images'
    alias drmi='docker rmi'
    alias drm='docker rm'
    alias dprune='docker system prune -af'
    alias dstop='docker stop $(docker ps -aq)'
    alias dkill='docker kill $(docker ps -aq)'
fi

# Kubernetes aliases
if command -v kubectl >/dev/null 2>&1; then
    export KUBECONFIG="$HOME/.kube/config"
    alias k='kubectl'
    alias ka='kubectl apply -f'
    alias kg='kubectl get'
    alias kd='kubectl describe'
    alias kdel='kubectl delete'
    alias kl='kubectl logs -f'
    alias kgpo='kubectl get pod'
    alias kgd='kubectl get deployments'
    alias kgs='kubectl get services'
    alias kgn='kubectl get nodes'
    alias ke='kubectl exec -it'
    alias kcns='kubectl config set-context --current --namespace'
    alias kport='kubectl port-forward'

    # kubectx and kubens if available
    command -v kubectx >/dev/null 2>&1 && alias kc='kubectx'
    command -v kubens >/dev/null 2>&1 && alias kns='kubens'
fi

# HTTP requests
command -v xh >/dev/null 2>&1 && alias http='xh'
command -v httpie >/dev/null 2>&1 && alias http='http'

# Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'

# ============================================================================
# EXTERNAL INTEGRATIONS
# ============================================================================

# fzf integration
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"

    # Custom fzf configuration
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info --preview-window=right:60%:wrap"

    # Use fd if available, otherwise fall back to find
    if command -v fd >/dev/null 2>&1; then
        export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
    else
        export FZF_DEFAULT_COMMAND='find . -type f -not -path "*/\.git/*" 2>/dev/null'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND='find . -type d -not -path "*/\.git/*" 2>/dev/null'
    fi

    # fzf preview commands
    export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
    export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
fi

# zoxide integration (better cd)
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# thefuck integration
if command -v thefuck >/dev/null 2>&1; then
    eval "$(thefuck --alias)"
fi

# oh-my-posh prompt
if command -v oh-my-posh >/dev/null 2>&1; then
    # Try to find the theme file in platform-specific locations
    if command -v brew >/dev/null 2>&1 && [[ -f "$(brew --prefix oh-my-posh)/themes/pure.omp.json" ]]; then
        # macOS with Homebrew - use dynamic brew prefix
        eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/pure.omp.json)"
    elif [[ -f "$HOME/.cache/oh-my-posh/themes/pure.omp.json" ]]; then
        # Linux or other locations
        eval "$(oh-my-posh init zsh --config $HOME/.cache/oh-my-posh/themes/pure.omp.json)"
    else
        echo "oh-my-posh theme file not found in expected locations"
    fi
fi

# ============================================================================
# LANGUAGE MANAGERS
# ============================================================================

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    # Lazy load NVM for faster shell startup
    nvm() {
        unset -f nvm
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        nvm "$@"
    }
fi

# Deno
if [[ -f "$HOME/.deno/env" ]]; then
    source "$HOME/.deno/env"
fi

# Python pyenv
if command -v pyenv >/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Ruby rbenv
if command -v rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Better find function
ff() {
    find . -type f -iname "*$1*" 2>/dev/null
}

# Better grep function
grepr() {
    grep -r -n -H -C 5 --exclude-dir={.git,.svn,CVS} "$1" .
}

# Extract various archive types
extract() {
    if [[ -f $1 ]]; then
        case $1 in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find and kill process by name
killprocess() {
    if [[ -z "$1" ]]; then
        echo "Usage: killprocess <process_name>"
        return 1
    fi
    ps aux | grep -i "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# Weather function (requires curl)
weather() {
    local city="${1:-Bhopal}"
    if [[ -z "$city" ]]; then
        curl -s "wttr.in/?format=3"
    else
        curl -s "wttr.in/${city}?format=3"
    fi
}

# Quick backup function
backup() {
    if [[ -z "$1" ]]; then
        echo "Usage: backup <file_or_directory>"
        return 1
    fi
    cp -r "$1" "${1}.backup.$(date +%Y%m%d_%H%M%S)" && echo "Backup created: ${1}.backup.$(date +%Y%m%d_%H%M%S)"
}

# Quick note function
note() {
    echo "$(date): $*" >> "$HOME/Documents/term-notes.txt"
}

# View notes
notes() {
    if [[ -f "$HOME/Documents/term-notes.txt" ]]; then
        cat "$HOME/Documents/term-notes.txt"
    else
        echo "No notes found"
    fi
}

# System info
sysinfo() {
    echo "System Information:"
    echo "==================="
    echo "Hostname: $(hostname)"
    echo "Uptime: $(uptime -p)"
    echo "Load Average: $(uptime | awk -F'load average:' '{print $2}')"
    echo "Memory Usage: $(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
    echo "Disk Usage: $(df -h / | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')"
    echo "CPU: $(grep -m 1 'model name' /proc/cpuinfo | cut -d':' -f2 | xargs)"
    echo "Kernel: $(uname -r)"
    echo "OS: $(lsb_release -d 2>/dev/null | cut -d':' -f2 | xargs || cat /etc/os-release | grep PRETTY_NAME | cut -d'=' -f2 | tr -d '"')"
}

# Git clone and cd
gclone() {
    git clone "$1" && cd "$(basename "$1" .git)"
}

# Create React app and cd
cra() {
    npx create-react-app "$1" && cd "$1"
}

# Docker quick commands
drun() {
    docker run -it --rm "$@"
}

dexec() {
    docker exec -it "$1" "${2:-bash}"
}

# Kubernetes quick commands
kexec() {
    kubectl exec -it "$1" -- "${2:-bash}"
}

klog() {
    kubectl logs -f "$1"
}

# ============================================================================
# CONDITIONAL CONFIGURATIONS
# ============================================================================

# Load SSH agent if available
if command -v ssh-agent >/dev/null 2>&1 && [[ -z "$SSH_AUTH_SOCK" ]]; then
    eval "$(ssh-agent -s)" >/dev/null
fi

# Load direnv if available
if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook zsh)"
fi

# Load conda if available
if [[ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
elif [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
fi

# ============================================================================
# FINAL SETUP
# ============================================================================

# Load local configuration if it exists
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# Clean up
unset -f add_to_path

# Welcome message
if [[ -o interactive ]]; then
    echo "🚀 Welcome back, $(whoami)!"
    echo "📅 $(date '+%A, %B %d, %Y at %I:%M %p')"
    echo "💻 $(uname -n) running $(uname -s) $(uname -r)"
    echo "🔧 Use 'sysinfo' for system details, 'weather' for weather, 'note' to jot down thoughts"
    echo ""
fi
