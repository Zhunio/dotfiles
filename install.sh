#!/bin/bash

print_run() {
  local blue='\033[0;34m'
  local bold='\033[1m'
  local reset='\033[0m'
  echo -e "${blue}==>${reset} ${bold}$1${reset}"
}

clone_repo_if_missing() {
  local repo_url=$1
  local target_dir=$2

  if [[ -d "$target_dir" ]]; then
    print_run "Cloning ${repo_url} (skipped)"
    return
  fi

  print_run "Cloning ${repo_url}"
  git clone "$repo_url" "$target_dir"
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    print_run "Installing Homebrew (skipped)"
    return
  fi

  print_run "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_homebrew_packages() {
  local packages=(
    "git"
    "gh"
    "neovim"
    "fzf"
    "ripgrep"
    "stow"
    "asmvik/formulae/skhd"
    "asmvik/formulae/yabai"
    "aerc"
    "eza"
    "mise"
    "oauth2l"
    "sesh"
    "starship"
    "tmux"
    "zoxide"
    "zsh-autocomplete"
  )
  local casks=(
    "font-victor-mono-nerd-font"
    "ghostty"
    "raycast"
    "shottr"
    "codex"
  )

  for package in "${packages[@]}"; do
    brew install "$package"
  done

  for cask in "${casks[@]}"; do
    brew install --cask "$cask"
  done
}

source_dotfiles() {
  local zshrc_file="$HOME/.zshrc"

  echo ""
  if [[ -f "$zshrc_file" ]] && grep -q "source \$HOME/dotfiles/dotfiles\.sh" "$zshrc_file"; then
    print_run "Sourcing dotfiles in \$HOME/.zshrc file (skipped)"
    return
  fi

  print_run "Sourcing dotfiles in \$HOME/.zshrc file"
  echo 'source $HOME/dotfiles/dotfiles.sh' >>"$zshrc_file"
}

stow_dotfiles() {
  local dotfiles_dir=$1
  local cwd
  cwd=$(pwd)

  cd "$dotfiles_dir"
  print_run "Creating symlinks using GNU Stow"
  stow .
  cd "$cwd"
}

install_macos_extras() {
  if pgrep -x yabai >/dev/null; then
    print_run "Restarting yabai service"
    yabai --restart-service
  else
    print_run "Starting yabai service"
    yabai --start-service
  fi

  if pgrep -x skhd >/dev/null; then
    print_run "Restarting skhd service"
    skhd --restart-service
  else
    print_run "Starting skhd service"
    skhd --start-service
  fi
}

main() {
  clone_repo_if_missing "https://github.com/Zhunio/dotfiles.git" "$HOME/dotfiles"
  # clone_repo_if_missing "https://github.com/Zhunio/dotfiles-private.git" "$HOME/dotfiles-private"

  install_homebrew
  install_homebrew_packages
  source_dotfiles
  stow_dotfiles "$HOME/dotfiles"
  install_macos_extras
}

main "$@"
