#!/bin/zsh

# ----------------------------------
# Aliases
# ----------------------------------

# source alias.zsh
srca() {
	source $DOTFILES/zsh/scripts/alias.zsh
}

# ----------------------------------
# Path
# ----------------------------------

# source path.zsh
srcp() {
	source $DOTFILES/zsh/scripts/path.zsh
}

#tmuxで既存セッションがあればnew-sessionせずにアタッチする
if [[ -z $TMUX && -n $PS1 ]]; then
	function attach_tmux() {
		if [[ $# == 0 ]] && tmux has-session 2>/dev/null; then
			command tmux attach-session
		else
			command tmux "$@"
		fi
	}
fi
