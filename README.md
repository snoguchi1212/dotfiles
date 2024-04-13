# dotfiles

## Setup

1. Set up Trackpad settings.

```(sh)
defaults write com.apple.AppleMultitouchTrackpad "FirstClickThreshold" -int "1"

defaults write NSGlobalDomain com.apple.trackpad.forceClick -int 1
defaults write NSGlobalDomain com.apple.trackpad.scaling -int 3
defaults write NSGlobalDomain com.apple.trackpad.scrolling -float 0.4412

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool false
```

2. Install Homebrew. (`https://brew.sh/`)
3. Install git & setup git.
```(sh)
brew install git
```
4. Install this repository at home dir.
5. Sign in with Apple ID
6. Run the below command to make symbolic link.

```(bash)
bash ~/dotfiles/bootstrap.sh && source ~/.zshrc
```

7. Then, run below command to install brew packages & mac apps.

```(sh)
bash $DOTFILES/brew/install.sh
```

8. Set up git, vim, etc...

## TODO

- [x] alacritty
- [x] bin
- [x] brew
- [x] espanso (text expander)
- [x] git
- [x] install
- [ ] karabiner (keyboard modifier)
- [ ] mutt (mail client)
- [x] nvim
- [x] scripts
- [ ] sketchybar
- [ ] skhd (keyboard binder)
- [x] starship
- [x] tmux
- [ ] yabai
- [x] zsh

## priority

1. zsh
2. git
3. brew
4. bin + scripts
5. install
6. starship
7. nvim
8. tmux
9. alacritty
10. yabai
11. karabiner (keyboard modifier)
12. skhd (keyboard binder)
13. neovide
