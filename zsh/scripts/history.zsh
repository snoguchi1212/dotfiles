#!/bin/zsh

# historyをzshで共有する
setopt share_history

# 重複するhistoryを残さない
setopt hist_ignore_dups

# 即座に履歴を保存する
setopt inc_append_history

# 設定項目
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000

# ----------------------------------
# History
# ----------------------------------
# history search
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --query="$LBUFFER" --height 40% --reverse)
  CURSOR=${#BUFFER}
}
