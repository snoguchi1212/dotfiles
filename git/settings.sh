#!/bin/bash

DOTFILES="${HOME}/dotfiles"

mkdir -p "${HOME}/.config/git"

touch "${DOTFILES}/git/config/config.local"
ln -sf "${DOTFILES}/git/config/config" "${HOME}/.config/git/config"
ln -sf "${DOTFILES}/git/config/config.local" "${HOME}/.config/git/config.local"
ln -sf "${DOTFILES}/git/config/ignore" "${HOME}/.config/git/ignore"

# Common git settings
git config --global core.editor "vim"
git config --global include.path "${DOTFILES}/git/config/config.local"
git config --global core.excludesfile "${DOTFILES}/git/config/ignore"

# git credential manager
brew install --cask git-credential-manager

# initial git settings
read -rp "Enter your Git user.name: " git_user_name
read -rp "Enter your Git user.email: " git_user_email

git config --file ${DOTFILES}/git/config/config.local user.name "$git_user_name"
echo "Git user.name set to: ${git_user_name}"

git config --file ${DOTFILES}/git/config/config.local user.email "$git_user_email"
echo "Git user.email set to: ${git_user_email}"

echo "Git configuration:"
git config --list | grep "user.name\|user.email\|core.editor"

# git secrets
git secrets --register-aws --global

git secrets --install "${HOME}/.git-templates/git-secrets"
git config --global "${HOME}/init.templateDir ~/.git-templates/git-secrets"
