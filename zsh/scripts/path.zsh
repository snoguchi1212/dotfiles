#!/bin/zsh

source_if_exists() {
	if test -r "$1"; then
		source "$1"
	fi
}

# ------------------
# local file
# ------------------
# bin
export PATH="$DOTFILES/bin/scripts:$DOTFILES/bin/.local/scripts:$PATH"

# asdf
export PATH="/opt/homebrew/opt/asdf/libexec/asdf.sh:$PATH"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
