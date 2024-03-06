#!/bin/zsh

# -----------------
# Zsh configuration
# -----------------

##  File transaction ---------------------------------------

# pushdが自動で効くようにする
setopt auto_pushd

# 重複するpushdを保存しない
setopt pushd_ignore_dups

# cdなしで移動できる
# setopt auto_cd

## Input/output

# 音を鳴らさない
# setopt no_beep

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -v
# bindkey -e

# history search
zle -N select-history
bindkey '^R' select-history
# bindkey '^R' history-incremental-search-backward

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{gre en}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]/}
