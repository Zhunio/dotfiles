#!/bin/bash

# Colors for output
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

DOTFILES_REPO="https://github.com/Zhunio/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"
DOTFILES_PRIVATE_REPO="https://github.com/Zhunio/dotfiles-private.git"
DOTFILES_PRIVATE_DIR="$HOME/dotfiles-private"

print_run() {
  echo -e "${BLUE}==>${RESET} ${BOLD}$1${RESET}"
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

install_oh_my_zsh() {
  export KEEP_ZSHRC=yes

  if [[ -d "$ZSH" ]]; then
    print_run "Installing Oh My Zsh (skipped)"
    return
  fi

  print_run "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    print_run "Installing Homebrew (skipped)"
    return
  fi

  print_run "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

update_homebrew() {
  print_run "Updating Homebrew"
  brew update
}

core_packages=(
  "git"
  "gh"
  "neovim"
  "ripgrep"
  "stow"
)

macos_packages=(
  "asmvik/formulae/skhd"
  "asmvik/formulae/yabai"
  "aerc"
  "direnv"
  "eza"
  "fzf"
  "mise"
  "oauth2l"
  "sesh"
  "starship"
  "tmux"
  "zoxide"
  "zsh-autocomplete"
)

macos_casks=(
  "font-meslo-lg-nerd-font"
  "ghostty"
  "visual-studio-code"
  "raycast"
  "shottr"
  "claude-code"
  "codex"
)

install_homebrew_packages() {
  for package in "${core_packages[@]}"; do
    brew install "$package"
  done
}

ensure_dotfiles_are_sourced() {
  local zshrc_file="$HOME/.zshrc"

  echo ""
  if grep -q "source \$HOME/dotfiles/dotfiles\.sh" "$zshrc_file"; then
    print_run "Sourcing dotfiles in \$HOME/.zshrc file (skipped)"
    return
  fi

  print_run "Sourcing dotfiles in \$HOME/.zshrc file"
  echo 'source $HOME/dotfiles/dotfiles.sh' >>"$zshrc_file"
}

stow_dotfiles() {
  local cwd
  cwd=$(pwd)

  cd "$DOTFILES_DIR"
  print_run "Creating symlinks using GNU Stow"
  stow .
  cd "$cwd"
}

install_macos_extras() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    return
  fi

  for package in "${macos_packages[@]}"; do
    brew install "$package"
  done

  for cask in "${macos_casks[@]}"; do
    brew install --cask "$cask"
  done

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
  clone_repo_if_missing "$DOTFILES_REPO" "$DOTFILES_DIR"
  clone_repo_if_missing "$DOTFILES_PRIVATE_REPO" "$DOTFILES_PRIVATE_DIR"
  install_oh_my_zsh
  install_homebrew
  update_homebrew
  install_homebrew_packages
  ensure_dotfiles_are_sourced
  stow_dotfiles
  install_macos_extras
}

main "$@"
