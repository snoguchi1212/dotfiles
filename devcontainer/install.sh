#!/bin/sh

# Devcontainer setup script
# This script sets up starship, git config, and useful aliases for devcontainers

set -e

# Get the directory where this script is located (POSIX compatible)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

# Use sudo if available and not root, otherwise run directly
if [ "$(id -u)" = "0" ]; then
    SUDO=""
else
    SUDO="sudo"
fi

# Detect package manager
detect_pkg_manager() {
    if command -v apk > /dev/null 2>&1; then
        echo "apk"
    elif command -v apt-get > /dev/null 2>&1; then
        echo "apt"
    elif command -v yum > /dev/null 2>&1; then
        echo "yum"
    else
        echo "unknown"
    fi
}

PKG_MANAGER=$(detect_pkg_manager)

# Function to install Homebrew and packages (for glibc-based systems)
install_homebrew_packages() {
    echo "Installing Homebrew..."
    if ! command -v brew > /dev/null 2>&1; then
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

    echo "Installing brew packages..."
    brew bundle --file "${SCRIPT_DIR}/Brewfile"
}

echo "Setting up devcontainer environment..."
echo "Detected package manager: $PKG_MANAGER"

# ===================
# Prerequisites & Packages
# ===================
echo "Installing packages..."

# Function to install git-secrets from source
install_git_secrets() {
    if command -v git-secrets > /dev/null 2>&1; then
        echo "git-secrets is already installed"
        return
    fi

    echo "Installing git-secrets from source..."
    TEMP_DIR=$(mktemp -d)
    git clone https://github.com/awslabs/git-secrets.git "$TEMP_DIR/git-secrets"
    cd "$TEMP_DIR/git-secrets"
    $SUDO make install
    cd -
    rm -rf "$TEMP_DIR"
    echo "git-secrets installed successfully"
}

case "$PKG_MANAGER" in
    apk)
        # Alpine Linux - install everything via apk (Homebrew not supported)
        $SUDO apk add --no-cache \
            curl git build-base procps file bash \
            zsh starship neovim eza tree fzf bat less jq
        # Install git-secrets from source (not available in apk)
        install_git_secrets
        ;;
    apt)
        $SUDO apt-get update
        $SUDO apt-get install -y curl git build-essential procps file
        install_homebrew_packages
        # Install git-secrets from source (not in Homebrew by default)
        install_git_secrets
        ;;
    yum)
        $SUDO yum install -y curl git gcc make procps-ng file
        install_homebrew_packages
        # Install git-secrets from source
        install_git_secrets
        ;;
    *)
        echo "Warning: Unknown package manager, skipping package installation"
        ;;
esac

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
    if command -v zsh > /dev/null 2>&1; then
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

        # Set zsh as default shell
        ZSH_PATH=$(which zsh)
        CURRENT_USER=$(whoami)

        # Add zsh to /etc/shells if not present
        if ! grep -q "$ZSH_PATH" /etc/shells 2>/dev/null; then
            echo "$ZSH_PATH" | $SUDO tee -a /etc/shells > /dev/null
        fi

        # Try chsh first, fall back to sed for Alpine
        if command -v chsh > /dev/null 2>&1; then
            $SUDO chsh -s "$ZSH_PATH" "$CURRENT_USER" 2>/dev/null || true
        fi

        # For Alpine Linux: directly modify /etc/passwd
        if [ "$PKG_MANAGER" = "apk" ]; then
            $SUDO sed -i "s|^\(${CURRENT_USER}:.*:\)[^:]*$|\1${ZSH_PATH}|" /etc/passwd
        fi

        echo "Set zsh as default shell"
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
