#!/bin/zsh

# ===================
# Devcontainer .zshrc
# ===================

# Helper function
source_if_exists() {
    if test -r "$1"; then
        source "$1"
    fi
}

# ===================
# Environment
# ===================
export DOTFILES=${DOTFILES:-$HOME/dotfiles}
export LANG=ja_JP.UTF-8
export EDITOR=nvim

# ===================
# Homebrew
# ===================
if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -f /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ===================
# History
# ===================
setopt share_history
setopt hist_ignore_dups
setopt inc_append_history

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# ===================
# Zim configuration
# ===================

# zsh-autosuggestions
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Initialize zimfw
ZIM_HOME=~/.zim
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
    source ${ZIM_HOME}/zimfw.zsh init -q
fi
source ${ZIM_HOME}/init.zsh

# ===================
# Aliases
# ===================
# ls (eza)
if command -v eza &> /dev/null; then
    alias ls="eza"
    alias ll="eza -la"
    alias la="eza -a"
    alias l="eza -l"
else
    alias ls="ls --color=auto"
    alias ll="ls -la"
    alias la="ls -A"
    alias l="ls -l"
fi

# rm (gomi)
if command -v gomi &> /dev/null; then
    alias rm="gomi"
fi

# Navigation
alias ..="cd .."
alias ...="cd ../.."

# grep
alias grep="grep --color=auto"

# vim
if command -v nvim &> /dev/null; then
    alias vi="nvim"
    alias vim="nvim"
    alias view="nvim -R"
fi

# git
alias g="git"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias gd="git diff"
alias gl="git log --oneline"
alias gs="git status"
alias gp="git push"
alias gpl="git pull"

# ===================
# FZF
# ===================
export FZF_DEFAULT_OPTS="--reverse --no-sort --no-hscroll --preview-window=down"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ===================
# Starship
# ===================
if command -v starship &> /dev/null; then
    eval "$(starship init zsh)"
fi
