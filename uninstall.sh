#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

print_run() {
  local blue='\033[0;34m'
  local bold='\033[1m'
  local reset='\033[0m'
  echo -e "${blue}==>${reset} ${bold}$1${reset}"
}

unstow_dotfiles() {
  local cwd
  cwd=$(pwd)

  if [[ ! -d "$DOTFILES_DIR" ]]; then
    print_run "Deleting symlinks using GNU Stow (skipped)"
    return
  fi

  cd "$DOTFILES_DIR"
  print_run "Deleting symlinks using GNU Stow"
  stow -D .
  cd "$cwd"
}

remove_zshrc_dotfiles_config() {
  local zshrc_file="$HOME/.zshrc"

  if [[ ! -f "$zshrc_file" ]]; then
    print_run "Removing dotfiles config from \$HOME/.zshrc (skipped)"
    return
  fi

  print_run "Removing dotfiles config from \$HOME/.zshrc"
  awk '
    $0 != "source $HOME/dotfiles/dotfiles.sh" &&
    $0 != "export DOTFILES_PROFILE=core" &&
    $0 != "export DOTFILES_PROFILE=full" { print }
  ' "$zshrc_file" >"$zshrc_file.tmp" && mv "$zshrc_file.tmp" "$zshrc_file"
}

uninstall_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    print_run "Uninstalling Homebrew packages (skipped)"
    print_run "Uninstalling Homebrew (skipped)"
    return
  fi

  print_run "Uninstalling Homebrew packages"
  brew list -1 | xargs brew uninstall --force

  print_run "Uninstalling Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)" -- --force
}

remove_paths() {
  local paths_to_delete=(
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
      print_run "Removing $path_to_delete"
      rm -rf "$path_to_delete"
    else
      print_run "Removing $path_to_delete (skipped)"
    fi
  done
}

main() {
  print_run "Uninstalling dotfiles"
  unstow_dotfiles
  remove_zshrc_dotfiles_config
  uninstall_homebrew
  remove_paths
}

main "$@"
