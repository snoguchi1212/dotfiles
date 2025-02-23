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
export PATH="$DOTFILES/bin:$DOTFILES/bin/scripts:$PATH"

for dir in $(find "$HOME/.local/scripts" -type d -maxdepth 1); do
	export PATH="$dir:$PATH"
done

# asdf
export PATH="/opt/homebrew/opt/asdf/libexec/asdf.sh:$PATH"
. /opt/homebrew/opt/asdf/libexec/asdf.sh
