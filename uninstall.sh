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

paths_to_delete=(
  "$HOME/dotfiles"
  "$HOME/.local/share/nvim"
  "$HOME/.cache"
  "$HOME/.copilot"
  "$HOME/.gnupg"
  "$HOME/.mail"
  "$HOME/.node-gyp"
  "$HOME/.npm"
  "$HOME/.oh-my-zsh"
  "$HOME/.suitecloud-sdk"
  "$HOME/.w3m"
)

for path_to_delete in "${paths_to_delete[@]}"; do
  if [[ -d "$path_to_delete" ]]; then
    echo -e "${BLUE}==>${RESET} 💀 ${BOLD}Removing $path_to_delete${RESET}"
    rm -rf "$path_to_delete"
  else
    echo -e "${BLUE}==>${RESET} 💀 Removing $path_to_delete ${BOLD}(skipped)${RESET}"
  fi
done
