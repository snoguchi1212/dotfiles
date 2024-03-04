#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")/.."
DOTFILES=$(pwd -P)

set -e

echo ''

info() {
	printf "\r  [ \033[1;38;5;51minfo\033[0m ] %s\n" "$1"
}

user() {
	printf "\r  [ \033[0;33m??\033[0m ] %s\n" "$1"
}

success() {
	printf "\r\033[2K  [ \033[1;32mOK\033[0m ] %s\n" "$1"
}

fail() {
	printf "\r\033[2K  [\033[1;31mFAIL\033[0m] %s\n" "$1"
	echo ''
	exit
}

link_file() {
	local src=$1 dst=$2

	local overwrite=
	local backup=
	local skip=
	local action=

	if [ -f "${dst}" ] || [ -d "${dst}" ] || [ -L "${dst}" ]; then

		if [ "$overwrite_all" = "false" ] && [ "$backup_all" = "false" ] && [ "$skip_all" = "false" ]; then

			# ignoring exit 1 from readlink in case where file already exists
			# shellcheck disable=SC2155
			local currentSrc=$(readlink -f "${dst}")

			if [ "${currentSrc}" = "$src" ]; then

				skip=true

			else

				user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
				[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
				read -rn 1 action </dev/tty

				case "$action" in
				o)
					overwrite=true
					;;
				O)
					overwrite_all=true
					;;
				b)
					backup=true
					;;
				B)
					backup_all=true
					;;
				s)
					skip=true
					;;
				S)
					skip_all=true
					;;
				*) ;;
				esac

			fi

		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if [ "$overwrite" = "true" ]; then
			rm -rf "$dst"
			success "removed $dst"
		fi

		if [ "$backup" = "true" ]; then
			mv "$dst" "${dst}.backup"
			success "moved $dst to ${dst}.backup"
		fi

		if [ "$skip" = "true" ]; then
			success "skipped $src"
		fi
	fi

	if [ "$skip" != "true" ]; then # "false" or empty
		ln -s "$1" "$2"
		success "linked $1 to $2"
	fi
}

install_dotfiles() {
	echo 'installing dotfiles'

	local overwrite_all=false backup_all=false skip_all=false
	local src dst dir
	original_IFS=$IFS
	IFS=
	while read -r linkfile; do
		while read -r line; do
			src=$(eval echo "${line}" | cut -d '=' -f 1)
			dst=$(eval echo "${line}" | cut -d '=' -f 2)
			dir=$(dirname "${dst}")

			mkdir -p "${dir}"
			link_file "${src}" "${dst}"
		done <"${linkfile}"
	done < <(find -H "${DOTFILES}" -maxdepth 2 -name 'links.prop' -not -path '*.git*')
	IFS=$original_IFS
}
create_local_alias_file() {
	if test -f "${DOTFILES}/zsh/scripts/alias.local.zsh"; then
		success "${DOTFILES}/zsh/scripts/alias.local.zsh file already exists, skipping"
	else
		touch "${DOTFILES}/zsh/scripts/alias.local.zsh"
		success "created ${DOTFILES}/zsh/scripts/alias.local.zsh"
	fi
}

create_env_file() {
	if test -f "${DOTFILES}/zsh/scripts/env.zsh"; then
		success "${DOTFILES}/zsh/scripts/env.zsh file already exists, skipping"
	else
		cat <<-EOF >"${DOTFILES}/zsh/scripts/env.zsh"
			export DOTFILES=$DOTFILES
			export EDITOR=/opt/homebrew/bin/nvim
		EOF
	fi
}

install_dotfiles
create_local_alias_file
create_env_file

echo ''
echo ''
success 'All installed!'
