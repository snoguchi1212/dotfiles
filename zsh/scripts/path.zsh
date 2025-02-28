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
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# docker
export PATH=$HOME/.docker/bin:$PATH
