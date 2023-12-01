# -------------
# Console Theme
# -------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


# -----
# alias
# -----

## local file

# alias preview="/Users/shoki/ShellScript/applications/open_preview.sh"
alias tool="cd ~/Tool"
alias imageConverter="open ~/Tool/imageConverter/app/images/"
alias savvy="cd ~/Dropbox/のぐちしょうき/mathQuestions/savvy/"
alias bedrock="cd /Users/snoguchi/Library/CloudStorage/GoogleDrive-snoguchi.nbsr@gmail.com/Shared\ drives/基盤の数学/bedrock/"
alias beenos="cd ~/Dropbox/BEENOS"

alias cdmachine="cd ~/Sandbox/python/machineLearning"
alias cdlaravel="cd ~/Sandbox/laravel/exercise-app"
alias journey="cd ~/Sandbox/ThreeJS/journey"
alias blueberry="code ~/Sandbox/React/blueberry/"
## applications

# alias pycharm='open -na "PyCharm.app" --args "$@"'

alias preview="open -a /System/Applications/Preview.app"
alias notion="open -a Notion"
alias ithoughts="open -a iThoughtsX.app"
alias typora="open -a typora"

## cloud file
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents"
alias college="cd /Users/snoguchi/Dropbox/college"

## MAMP
alias phpSandbox="cd /Applications/MAMP/htdocs/Sandbox"

## service

# editor config file copy
alias cpConfFile='cp -n ~/Library/Application\ Support/Code/User/.editorconfig .'
alias cpTexSnippets='mkdir -p ./.vscode/; cp -n ~/Library/Application\ Support/Code/User/snippets/tex.json ./.vscode/; mv ./.vscode/tex.json ./.vscode/tex.code-snippets 2>/dev/null'

# laravel
alias sail='[ -f sail ] && sh sail || sh vendor/bin/sail'

# vim
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"


# ----
# PATH
# ----

## local PATH

#export PATH="/Users/shoki/ShellScript/applications/":$PATH
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/Sandbox/python/deeplearning/bin:$PATH"

## services

# tex
# export PATH="/Library/TeX/texbin":$PATH

# asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
#asdfでphpをインストールするのに必要だったパス
export PATH="/opt/homebrew/opt/bison/bin:$PATH" 

# autojumpの設定
[[ -s /etc/profile.d/autojump.zsh ]] && . /etc/profile.d/autojump.zsh

# brew

## pallarelのせいでcurlが使えないことを防ぐ
export PATH="/opt/homebrew/opt/curl/bin:$PATH"

# -----------------
# Zsh configuration
# -----------------

##  File transaction

# pushdが自動で効くようにする
setopt auto_pushd

# 重複するpushdを保存しない
setopt pushd_ignore_dups

# cdなしで移動できる
# setopt auto_cd


## History

# historyをzshで共有する
setopt share_history

# 重複するhistoryを残さない
setopt hist_ignore_dups

# Remove older command from the history if a duplicate is to be added.
# setopt HIST_IGNORE_ALL_DUPS

# 即座に履歴を保存する
setopt inc_append_history

# HISTRY関係
export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000


## Input/output

# 音を鳴らさない
# setopt no_beep

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
setopt CORRECT

# Customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# --------------------
# Module configuration
# --------------------

## git

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

## zsh-autosuggestions

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

## zsh-syntax-highlighting

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# ohmyzshのプラグインを使えるようにするための設定
## (functionsを有効化している)
source ${ZIM_HOME}/modules/ohmyzsh/lib/functions.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/snoguchi/.asdf/installs/python/mambaforge-22.9.0-3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/snoguchi/.asdf/installs/python/mambaforge-22.9.0-3/etc/profile.d/conda.sh" ]; then
        . "/Users/snoguchi/.asdf/installs/python/mambaforge-22.9.0-3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/snoguchi/.asdf/installs/python/mambaforge-22.9.0-3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/snoguchi/.asdf/installs/python/mambaforge-22.9.0-3/etc/profile.d/mamba.sh" ]; then
    . "/Users/snoguchi/.asdf/installs/python/mambaforge-22.9.0-3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

