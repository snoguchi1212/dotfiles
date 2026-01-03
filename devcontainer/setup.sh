#!/bin/bash

# Devcontainer post-setup script
# Run this after devcontainer is created to complete the setup
#
# Usage:
#   ~/dotfiles/devcontainer/setup.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo "Running devcontainer post-setup..."

# ===================
# Git settings
# ===================
echo "Setting up Git configuration..."
bash "${DOTFILES_DIR}/git/settings.sh"

echo ""
echo "Devcontainer post-setup complete!"