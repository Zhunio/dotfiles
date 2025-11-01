#!/bin/bash

BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# save current working directory
cwd=$(pwd)

# Changing to $HOME/dotfiles directory
cd $HOME/dotfiles

# Uninstalling dotfiles
echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Uninstalling dotfiles${RESET}"

# Use GNU Stow to undo the symlinks
echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Deleting symlinks using GNU Stow${RESET}"
stow -D .

# go back to current working directory
cd $cwd

# Remove bin folder
if [[ -d $HOME/bin ]]; then
  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Removing bin folder: oh-my-zsh & Tmux Plugin Manager ${RESET}"
  rm -rf $HOME/bin
else
  echo -e "${BLUE}==>${RESET} 💀 Removing bin folder ${BOLD}(skipped)${RESET}"
fi

# Removing Brew packages
if command -v brew >/dev/null 2>&1; then
  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Uninstalling Homebrew packages${RESET}"
  brew list -1 | xargs brew uninstall --force

  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Uninstalling Homebrew${RESET}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)" -- --force
fi

# Remove dotfiles
if [[ -d $HOME/dotfiles ]]; then
  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Removing dotfiles ${RESET}"
  rm -rf $HOME/dotfiles
else
  echo -e "${BLUE}==>${RESET} 💀 Removing dotfiles ${BOLD}(skipped)${RESET}"
fi
