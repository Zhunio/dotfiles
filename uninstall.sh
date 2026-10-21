#!/bin/bash

set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

print_run() {
  local blue='\033[0;34m'
  local bold='\033[1m'
  local reset='\033[0m'
  echo -e "${blue}==>${reset} ${bold}$1${reset}"
}

unstow_dotfiles() {
  if [[ ! -d "$DOTFILES_DIR" ]]; then
    print_run "Deleting symlinks using GNU Stow (skipped)"
    return
  fi

  print_run "Deleting symlinks using GNU Stow"
  stow --dir="$DOTFILES_DIR" --target="$HOME" -D .
}

remove_zshrc_dotfiles_config() {
  local zshrc_file="$HOME/.zshrc"

  if [[ ! -f "$zshrc_file" ]]; then
    print_run "Removing dotfiles config from \$HOME/.zshrc (skipped)"
    return
  fi

  print_run "Removing dotfiles config from \$HOME/.zshrc"
  awk '
    $0 != "source $HOME/dotfiles/dotfiles.sh" { print }
  ' "$zshrc_file" >"$zshrc_file.tmp" && mv "$zshrc_file.tmp" "$zshrc_file"
}

main() {
  print_run "Uninstalling dotfiles"
  unstow_dotfiles
  remove_zshrc_dotfiles_config
  print_run "Packages, repositories, user data, and the dotfiles checkout were preserved"
}

main "$@"
