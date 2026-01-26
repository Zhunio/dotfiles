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

# Removing Brew packages
if command -v brew >/dev/null 2>&1; then
  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Uninstalling Homebrew packages${RESET}"
  brew list -1 | xargs brew uninstall --force

  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Uninstalling Homebrew${RESET}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)" -- --force
fi

# Remove nvim packages
if [[ -d $HOME/.local/share/nvim ]]; then
  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Removing ~/.local/share/nvim ${RESET}"
  rm -rf $HOME/.local/share/nvim
else
  echo -e "${BLUE}==>${RESET} 💀 Removing ~/.local/share/nvim ${BOLD}(skipped)${RESET}"
fi

# Remove dotfiles
if [[ -d $HOME/dotfiles ]]; then
  echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Removing dotfiles ${RESET}"
  rm -rf $HOME/dotfiles
else
  echo -e "${BLUE}==>${RESET} 💀 Removing dotfiles ${BOLD}(skipped)${RESET}"
fi

directories=(
  ".cache"
  ".copilot"
  ".gnupg"
  ".mail"
  ".node-gyp"
  ".npm"
  ".oh-my-zsh"
  ".suitecloud-sdk"
  ".w3m"
)

for dir in "${directories[@]}"; do
  if [[ -d $HOME/$dir ]]; then
    echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Removing $dir directory${RESET}"
    rm -rf $HOME/$dir
  else
    echo -e "${BLUE}==>${RESET} 💀 Removing $dir directory ${BOLD}(skipped)${RESET}"
  fi
done
