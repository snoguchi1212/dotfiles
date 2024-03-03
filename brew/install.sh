#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install base packages
brew bundle --file "${DOTFILES}/brew/brewfile/base.Brewfile"

# Install applications
brew bundle --file "${DOTFILES}/brew/brewfile/adobe.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/e-residency.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/filesystem.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/font.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/game.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/media.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/messaging.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/office.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/secret.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/util.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/web.Brewfile"

# Install dev packages
brew bundle --file "${DOTFILES}/brew/brewfile/dev-3d.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-android.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-container.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-db.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-design.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-ide.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-network.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-terminal.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-vcs.Brewfile"
brew bundle --file "${DOTFILES}/brew/brewfile/dev-web.Brewfile"

# Install devops packages in `devops.Brewfile`
brew bundle --file "${DOTFILES}/brew/brewfile/devops.Brewfile"

# setup
"$(brew --prefix)"/opt/fzf/install
