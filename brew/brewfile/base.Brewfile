# base.Brewfile

cask_args appdir: '/Applications'

# Alternate versions of Casks
# tap 'homebrew/cask-versions'
# Integrates Homebrew formulae with macOS' `launchctl` manager
tap 'homebrew/services'
# A CLI tool upgrading every outdated app installed by Homebrew Cask
# INFO: brew cu
tap 'buo/cask-upgrade'

### System Library {{{
  # Get a file from an HTTP, HTTPS or FTP server
  brew 'curl'
  # Internet file retriever
  brew 'wget'
### }}}

### vcs {{{
  brew 'git'
### }}}

### Utility {{{
  ## Mac OS X
  # Mac App Store command line interface
  brew 'mas' if OS.mac?
  # System Utilities for macOS
  # cask 'onyx' if OS.mac?
  # Swiss Army Knife for macOS
  brew 'm-cli' if OS.mac?

  ## Mac OS X: Quick Look Plugins
  # An Application for Inspecting macOS Installer Packages
  # cask 'suspicious-package' if OS.mac?
### }}}