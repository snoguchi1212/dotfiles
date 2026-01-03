#!/bin/zsh

source_if_exists() {
	if test -r "$1"; then
		source "$1"
	fi
}

# ------------------
# zsh files
# ------------------
alias vialiaslocal="vim $DOTFILES/zsh/scripts/alias.local.zsh"
alias vialias="vim $DOTFILES/zsh/scripts/alias.zsh"
alias viautoload="vim $DOTFILES/zsh/scripts/autoload.zsh"
alias viconfig="vim $DOTFILES/zsh/scripts/config.zsh"
alias vidocker="vim $DOTFILES/zsh/scripts/docker.zsh"
alias vienv="vim ${DOTFILES}/zsh/scripts/env.zsh"
alias vifunc="vim $DOTFILES/zsh/scripts/function.zsh"
alias vigit="vim $DOTFILES/zsh/scripts/git.zsh"
alias vihistory="vim $DOTFILES/zsh/scripts/history.zsh"
alias vipath="vim $DOTFILES/zsh/scripts/path.zsh"
alias vizim="vim $DOTFILES/zsh/scripts/zim.zsh"
alias zim="vim $DOTFILES/zsh/zim/zimrc.zsh"

# ------------------
# alacritty
# ------------------
alias vialacritty="vim $DOTFILES/alacritty/alacritty.toml"
alias vialacrittytheme="vim $DOTFILES/alacritty/theme.toml"

# ------------------
# bin
# ------------------
alias localbin="cd $DOTFILES/bin/.local/scripts"
alias bin="cd $DOTFILES/scripts"

# ------------------
# nvim
# ------------------
alias vzim="vim $DOTFILES/nvim/init.vim"

# ------------------
# starship
# ------------------
alias vistarship="vim $DOTFILES/starship/starship.toml"

# ------------------
# local file
# ------------------
[ -f $DOTFILES/zsh/scripts/alias.local.zsh ] && source $DOTFILES/zsh/scripts/alias.local.zsh

# ------------------
# cd alias
# ------------------
alias downloads="cd ~/Downloads"
alias dotfiles="cd $DOTFILES"

# ------------------
# Applications
# ------------------
alias preview="open -a /System/Applications/Preview.app"
alias notion="open -a Notion"
alias ithoughts="open -a iThoughtsX.app"
alias typora="open -a typora"
# alias pycharm='open -na "PyCharm.app" --args "$@"'

# ------------------
# Cloud
# ------------------
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents"
alias slack="~/.local/slack/slack"

# ------------------
# Shortcuts
# ------------------
# git
source_if_exists $DOTFILES/zsh/scripts/git.zsh

# docker
source_if_exists $DOTFILES/zsh/scripts/docker.zsh

# terraform
alias tf="terraform"

# vim
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# laravel
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# Linux Commands
alias ls="eza"
alias exa="eza"
alias rm="gomi"
