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
  if ! command -v port >/dev/null 2>&1; then
    echo "Install MacPorts from https://www.macports.org/install.php, then rerun this installer." >&2
    return 1
  fi

  if ! xcode-select -p >/dev/null 2>&1; then
    print_run "Installing Xcode Command Line Tools"
    xcode-select --install
    echo "Finish the Command Line Tools installation, then rerun this installer."
    return 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    print_run "Installing Git"
    sudo port install git
  fi
}

install_fedora_prereq() {
  sudo dnf install -y git curl
}

install_dmg() (
  app=$1
  url=$2

  if [[ -d "/Applications/$app.app" ]]; then
    print_run "Installing $app (skipped)"
    return
  fi

  print_run "Installing $app"
  curl -fL "$url" -o "$HOME/Downloads/$app.dmg"
  hdiutil attach "$HOME/Downloads/$app.dmg" -nobrowse -quiet
  sudo ditto "/Volumes/$app/$app.app" "/Applications/$app.app"
  hdiutil detach "/Volumes/$app" -quiet
)

install_macos_packages() {
  local macos_packages=(
    "opencode"
    "skhd"
    "yabai"
  )

  sudo port selfupdate
  sudo port install "${packages[@]}" "${macos_packages[@]}"

  install_dmg "Google Chrome" "https://dl.google.com/chrome/mac/universal/stable/GGRO/googlechrome.dmg"
  install_dmg "Ghostty" "https://release.files.ghostty.org/1.3.1/Ghostty.dmg"
  install_dmg "Shottr" "https://shottr.cc/dl/Shottr-1.9.3b.dmg"
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
    ghostty opencode-cli zsh wl-clipboard spectacle
    victormono-nerd-fonts
  )

  install_fedora_repos

  sudo dnf install -y "${packages[@]}" "${fedora_packages[@]}"

  if ! command -v google-chrome-stable >/dev/null 2>&1; then
    sudo rpm --import https://dl.google.com/linux/linux_signing_key.pub
    sudo dnf install -y --setopt=localpkg_gpgcheck=1 \
      https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
  fi

  print_run "Start zsh, or run chsh -s /usr/bin/zsh to make it your login shell"
}

install_zsh_autocomplete() {
  # Include the bundled z-async dependency on both platforms.
  local autocomplete_dir="$HOME/.local/share/zsh-autocomplete"
  if [[ ! -d "$autocomplete_dir" ]]; then
    print_run "Installing zsh-autocomplete with its bundled dependencies"
    mkdir -p "$(dirname "$autocomplete_dir")"
    git clone --depth 1 --branch 26.08.04 \
      https://github.com/marlonrichert/zsh-autocomplete.git "$autocomplete_dir"
  fi
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
    git gh neovim stow tmux
    eza mise starship yazi zoxide
  )

  case "$platform" in
    macos) install_macos_packages ;;
    fedora) install_fedora_packages ;;
  esac

  install_zsh_autocomplete

  stow_dotfiles "$HOME/dotfiles"

  source_dotfiles

  mise install

  if [[ "$platform" == macos ]]; then
    start_macos_services
  fi

}

main "$@"
