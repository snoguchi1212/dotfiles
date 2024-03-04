#!/bin/zsh

source_if_exists() {
  if test -r "$1"; then
    source "$1"
  fi
}

# -------------
# Read rc files
# -------------
DOTFILES=${HOME}/dotfiles

source_if_exists $DOTFILES/zsh/scripts/env.zsh
source_if_exists $DOTFILES/zsh/scripts/alias.zsh
source_if_exists $DOTFILES/zsh/scripts/autoload.zsh
source_if_exists $DOTFILES/zsh/scripts/config.zsh
source_if_exists $DOTFILES/zsh/scripts/function.zsh
source_if_exists $DOTFILES/zsh/scripts/history.zsh
source_if_exists $DOTFILES/zsh/scripts/path.zsh
source_if_exists $DOTFILES/zsh/scripts/zim.zsh
source_if_exists $DOTFILES/zsh/scripts/zim_suffix.zsh

# -------------
# hooks
# -------------
# direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"
