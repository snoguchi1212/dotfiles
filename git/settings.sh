#!/bin/bash

# Git settings script
# Works on both macOS and Linux (devcontainer)

set -e

DOTFILES="${HOME}/dotfiles"

# ===================
# Helper functions
# ===================
is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

run_sudo() {
    if [[ "$(id -u)" == "0" ]]; then
        "$@"
    else
        sudo "$@"
    fi
}

# ===================
# Git config files setup
# ===================
echo "Setting up git config files..."

mkdir -p "${HOME}/.config/git"

touch "${DOTFILES}/git/config/config.local"
ln -sf "${DOTFILES}/git/config/config" "${HOME}/.config/git/config"
ln -sf "${DOTFILES}/git/config/config.local" "${HOME}/.config/git/config.local"
ln -sf "${DOTFILES}/git/config/ignore" "${HOME}/.config/git/ignore"

# Common git settings (nvim -> vim -> vi fallback)
if command -v nvim > /dev/null 2>&1; then
    git config --global core.editor "nvim"
elif command -v vim > /dev/null 2>&1; then
    git config --global core.editor "vim"
else
    git config --global core.editor "vi"
fi
git config --global include.path "${HOME}/.config/git/config.local"
git config --global core.excludesfile "${HOME}/.config/git/ignore"

# ===================
# Git credential manager (macOS only)
# devcontainer では VS Code の credential forwarding 機能により
# ホストマシンの認証情報が自動転送されるため不要
# ===================
if is_macos; then
    echo "Installing git-credential-manager..."
    if ! brew list --cask git-credential-manager > /dev/null 2>&1; then
        brew install --cask git-credential-manager
    else
        echo "git-credential-manager is already installed"
    fi
fi

# ===================
# Git user settings
# ===================
echo "Setting up Git user configuration..."

read -rp "Enter your Git user.name: " git_user_name
read -rp "Enter your Git user.email: " git_user_email

git config --file "${DOTFILES}/git/config/config.local" user.name "$git_user_name"
echo "Git user.name set to: ${git_user_name}"

git config --file "${DOTFILES}/git/config/config.local" user.email "$git_user_email"
echo "Git user.email set to: ${git_user_email}"

# ===================
# git-secrets installation
# ===================
echo "Setting up git-secrets..."

if ! command -v git-secrets > /dev/null 2>&1; then
    echo "Installing git-secrets from source..."
    TEMP_DIR=$(mktemp -d)
    git clone https://github.com/awslabs/git-secrets.git "$TEMP_DIR/git-secrets"
    cd "$TEMP_DIR/git-secrets"
    run_sudo make install
    cd - > /dev/null
    rm -rf "$TEMP_DIR"
    echo "git-secrets installed successfully"
else
    echo "git-secrets is already installed"
fi

# ===================
# git-secrets configuration
# ===================
if command -v git-secrets > /dev/null 2>&1; then
    # Register AWS patterns globally
    git secrets --register-aws --global

    # Setup git-secrets template directory
    mkdir -p "${HOME}/.git-templates/git-secrets"
    git secrets --install "${HOME}/.git-templates/git-secrets"
    git config --global init.templateDir "${HOME}/.git-templates/git-secrets"

    echo "git-secrets configured successfully"
else
    echo "Warning: git-secrets installation failed"
fi

# ===================
# Summary
# ===================
echo ""
echo "Git configuration complete!"
echo "Current settings:"
git config --list | grep -E "user.name|user.email|core.editor|init.templateDir" || true