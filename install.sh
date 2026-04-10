#!/bin/bash

DOTFILES_PROFILE="core"

print_run() {
  local blue='\033[0;34m'
  local bold='\033[1m'
  local reset='\033[0m'
  echo -e "${blue}==>${reset} ${bold}$1${reset}"
}

usage() {
  cat <<EOF
Usage: install.sh [--profile core|full]
EOF
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --profile)
        shift
        if [[ -z "$1" ]]; then
          usage
          exit 1
        fi
        DOTFILES_PROFILE="$1"
        ;;
      -h|--help)
        usage
        exit 0
        ;;
      *)
        usage
        exit 1
        ;;
    esac
    shift
  done

  if [[ "$DOTFILES_PROFILE" != "core" && "$DOTFILES_PROFILE" != "full" ]]; then
    echo "Invalid profile: $DOTFILES_PROFILE" >&2
    usage
    exit 1
  fi
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
  local core_packages=(
    "git"
    "gh"
    "neovim"
    "fzf"
    "ripgrep"
    "stow"
  )
  local full_packages=(
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
  local full_casks=(
    "font-victor-mono-nerd-font"
    "ghostty"
    "visual-studio-code"
    "raycast"
    "shottr"
    "claude-code"
    "codex"
  )

  for package in "${core_packages[@]}"; do
    brew install "$package"
  done

  if [[ "$DOTFILES_PROFILE" == "full" ]]; then
    for package in "${full_packages[@]}"; do
      brew install "$package"
    done

    for cask in "${full_casks[@]}"; do
      brew install --cask "$cask"
    done
  fi
}

source_dotfiles() {
  local zshrc_file="$HOME/.zshrc"
  local profile_line="export DOTFILES_PROFILE=${DOTFILES_PROFILE}"

  echo ""
  if [[ -f "$zshrc_file" ]]; then
    awk '
      $0 != "export DOTFILES_PROFILE=core" && $0 != "export DOTFILES_PROFILE=full" { print }
    ' "$zshrc_file" >"$zshrc_file.tmp" && mv "$zshrc_file.tmp" "$zshrc_file"
  fi

  echo "$profile_line" >>"$zshrc_file"

  if grep -q "source \$HOME/dotfiles/dotfiles\.sh" "$zshrc_file"; then
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
  if [[ "$(uname -s)" != "Darwin" ]]; then
    return
  fi

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
  parse_args "$@"
  clone_repo_if_missing "https://github.com/Zhunio/dotfiles.git" "$HOME/dotfiles"
  clone_repo_if_missing "https://github.com/Zhunio/dotfiles-private.git" "$HOME/dotfiles-private"

  install_homebrew
  install_homebrew_packages
  source_dotfiles
  stow_dotfiles "$HOME/dotfiles"
  install_macos_extras
}

main "$@"
