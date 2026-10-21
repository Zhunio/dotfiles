#!/bin/bash

set -euo pipefail

detect_platform() {
  local os
  os="$(uname -s)"

  case "$os" in
    Darwin) platform=macos; return ;;
    Linux) platform=fedora; return ;;
  esac
  echo "Unsupported OS: $os" >&2
  return 1
}

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

install_macos_prereq() {
  if xcode-select -p >/dev/null 2>&1 && xcrun --find git >/dev/null 2>&1; then
    return
  fi

  print_run "Installing Xcode Command Line Tools"
  xcode-select --install
  echo "Finish the Command Line Tools installation, then rerun this installer."
  exit 1
}

install_fedora_prereq() {
  sudo dnf install -y git curl
}

install_homebrew_if_missing() {
  if command -v brew >/dev/null 2>&1; then
    print_run "Installing Homebrew (skipped)"
    return
  fi

  print_run "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

install_macos_packages() {
  local macos_packages=(
    "opencode"
    "zsh-autocomplete"
    "asmvik/formulae/skhd"
    "asmvik/formulae/yabai"
  )
  local casks=(
    "font-victor-mono-nerd-font"
    "ghostty"
    "google-chrome"
    "raycast"
    "shottr"
  )

  install_homebrew_if_missing

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi

  brew install "${packages[@]}" "${macos_packages[@]}"
  brew install --cask "${casks[@]}"
}

install_fedora_repos() {
  if ! rpm -q terra-release terra-gpg-keys >/dev/null 2>&1; then
    sudo dnf install -y --nogpgcheck \
      --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' \
      terra-release terra-gpg-keys
  fi
}

install_fedora_packages() {
  local fedora_packages=(
    ghostty opencode-cli zsh wl-clipboard
    victormono-nerd-fonts
  )

  install_fedora_repos

  sudo dnf install -y "${packages[@]}" "${fedora_packages[@]}"

  # The Fedora package omits the bundled z-async dependency.
  local autocomplete_dir="$HOME/.local/share/zsh-autocomplete"
  if [[ ! -d "$autocomplete_dir" ]]; then
    print_run "Installing zsh-autocomplete with its bundled dependencies"
    git clone --depth 1 --branch 26.08.04 \
      https://github.com/marlonrichert/zsh-autocomplete.git "$autocomplete_dir"
  fi

  if ! command -v google-chrome-stable >/dev/null 2>&1; then
    sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
    sudo dnf install -y --setopt=localpkg_gpgcheck=1 \
      https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
  fi

  print_run "Start zsh, or run chsh -s /usr/bin/zsh to make it your login shell"
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
  print_run "Creating symlinks using GNU Stow"
  stow --dir="$dotfiles_dir" --target="$HOME" --no-folding --simulate .
  stow --dir="$dotfiles_dir" --target="$HOME" --no-folding .
}

start_macos_services() {
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
  local platform
  detect_platform

  case "$platform" in
    macos) install_macos_prereq ;;
    fedora) install_fedora_prereq ;;
  esac

  clone_repo_if_missing "https://github.com/Zhunio/dotfiles.git" "$HOME/dotfiles"

  local packages=(
    git gh neovim fzf ripgrep stow tmux visidata wget
    eza mise starship yazi zoxide
  )

  case "$platform" in
    macos) install_macos_packages ;;
    fedora) install_fedora_packages ;;
  esac

  stow_dotfiles "$HOME/dotfiles"

  source_dotfiles

  mise install

  if [[ "$platform" == macos ]]; then
    start_macos_services
  fi

}

main "$@"
