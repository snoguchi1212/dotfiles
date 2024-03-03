#!/bin/zsh

autoload -U zmv
autoload -U promptinit && promptinit
autoload -U colors && colors
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/opt/homebrew/bin/aws_completer' aws
