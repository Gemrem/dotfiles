#!/usr/bin/env sh

#!/usr/bin/env sh
set -eu

have_cmd() { command -v "$1" >/dev/null 2>&1; }

ensure_brew() {
  if have_cmd brew; then
    printf "Brew already installed\n\n"
    return 0
  fi

  printf "Brew not found\n\n"
  printf "Installing brew...\n"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

brew_formula() {
  cmd="$1"
  formula="${2:-$1}"

  if have_cmd "$cmd"; then
    printf "%s already installed\n" "$cmd"
    return 0
  fi

  printf "%s not found\nInstalling %s...\n" "$cmd" "$formula"
  brew install -q "$formula"
}

brew_cask() {
  cask="$1"

  if brew list --cask "$cask" >/dev/null 2>&1; then
    printf "%s (cask) already installed\n" "$cask"
    return 0
  fi

  printf "%s (cask) not found\nInstalling %s...\n" "$cask" "$cask"
  brew install --cask -q "$cask"
}

ensure_brew

# CLI tools (formulae)
brew_formula git
brew_formula htop
brew_formula curl
brew_formula nvim nvim@0.11.5
brew_formula tmux
brew_formula tree-sitter
brew_formula rg ripgrep
brew_formula ddev ddev/ddev/ddev
brew_formula fvm leoafarias/fvm/fvm

# Apps (casks)
brew_cask alacritty
brew_cask orbstack

# Setting config value for hammerspoon, so that config is in XDG_CONFIG_HOME
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
