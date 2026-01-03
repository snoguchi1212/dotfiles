#!/bin/bash

# Devcontainer setup script
# This script sets up starship, git config, and useful aliases for devcontainers

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo "Setting up devcontainer environment..."

# ===================
# Homebrew
# ===================
echo "Installing Homebrew..."
if ! command -v brew &> /dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add brew to PATH for current session
    if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -f /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew is already installed"
fi

# ===================
# Brew packages
# ===================
echo "Installing brew packages..."
brew bundle --file "${SCRIPT_DIR}/Brewfile"

# ===================
# Starship config
# ===================
echo "Setting up starship config..."
mkdir -p ~/.config
ln -sf "${DOTFILES_DIR}/starship/starship.toml" ~/.config/starship.toml

# ===================
# Neovim config
# ===================
echo "Setting up neovim config..."
mkdir -p ~/.config/nvim
ln -sf "${DOTFILES_DIR}/nvim/init.vim" ~/.config/nvim/init.vim

# ===================
# Git config
# ===================
echo "Setting up git config..."
mkdir -p ~/.config/git

ln -sf "${DOTFILES_DIR}/git/config/config" ~/.config/git/config
ln -sf "${DOTFILES_DIR}/git/config/ignore" ~/.config/git/ignore

# Create config.local if it doesn't exist (for user-specific settings)
if [ ! -f ~/.config/git/config.local ]; then
    touch ~/.config/git/config.local
fi

# ===================
# Shell configuration
# ===================
echo "Setting up shell configuration..."

# Check if running inside a devcontainer
if [ -n "${REMOTE_CONTAINERS}" ] || [ -n "${CODESPACES}" ] || [ -f /.dockerenv ]; then
    # Setup zshrc for devcontainer
    if command -v zsh &> /dev/null; then
        # Backup existing .zshrc if it exists and is not a symlink
        if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
            mv ~/.zshrc ~/.zshrc.backup
            echo "Backed up existing .zshrc to .zshrc.backup"
        fi
        ln -sf "${SCRIPT_DIR}/.zshrc" ~/.zshrc
        echo "Linked devcontainer .zshrc"

        # Setup .zimrc for devcontainer
        ln -sf "${SCRIPT_DIR}/zim/.zimrc" ~/.zimrc
        echo "Linked devcontainer .zimrc"
    fi

    # Setup bashrc with starship
    if [ -f ~/.bashrc ]; then
        if ! grep -q 'eval "$(starship init bash)"' ~/.bashrc; then
            echo 'eval "$(starship init bash)"' >> ~/.bashrc
        fi
    fi
else
    echo "Not running in devcontainer, skipping shell configuration"
    echo "To force setup, set REMOTE_CONTAINERS=1 environment variable"
fi

echo "Devcontainer setup complete!"
