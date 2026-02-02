#!/bin/bash

# Colors for output
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

print_run() {
  echo -e "${BLUE}==>${RESET} ${BOLD}$1${RESET}"
}

# --- Clone dotfiles repository ---
if [[ -d $HOME/dotfiles ]]; then
  print_run "Cloning https://github.com/Zhunio/dotfiles.git (skipped)"
else
  print_run "Cloning https://github.com/Zhunio/dotfiles.git"
  git clone https://github.com/Zhunio/dotfiles.git $HOME/dotfiles
fi

# --- Clone dotfiles-private repository ---
if [[ -d $HOME/dotfiles-private ]]; then
  print_run "Cloning https://github.com/Zhunio/dotfiles-private.git (skipped)"
else
  print_run "Cloning https://github.com/Zhunio/dotfiles-private.git"
  git clone https://github.com/Zhunio/dotfiles-private.git $HOME/dotfiles-private
fi

# --- Install Oh My Zsh ---
export KEEP_ZSHRC=yes

if [[ -d $ZSH ]]; then
  print_run "Installing Oh My Zsh (skipped)"
else
  print_run "Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Install Homebrew ---
if command -v brew >/dev/null 2>&1; then
  print_run "Installing Homebrew (skipped)"
else
  print_run "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  source $HOME/dotfiles/dotfiles_brew.sh
fi

# -- Update Homebrew ---
brew update

# --- Homebrew packages ---
packages=(
  "aerc"
  "aichat"
  "awscli"
  "bat"
  "btop"
  "fd"
  "fzf"
  "fnm"
  "eza"
  "git"
  "gh"
  "jq"
  "neovim"
  "oauth2l"
  "ripgrep"
  "stow"
  "tmux"
  "terraform"
  "zoxide"
  "zsh-autocomplete"
  "starship"
  "sesh"
  "yazi"
  "1password-cli"
)

# --- Homebrew casks ---
casks=(
  "font-meslo-lg-nerd-font"
)

# --- Install Homebrew packages ---
for package in "${packages[@]}"; do
  brew install "$package"
done

# --- Install Homebrew casks ---
for cask in "${casks[@]}"; do
  brew install --cask "$cask"
done

# --- Source dotfiles in .zshrc ---
echo ""
if grep -q "source \$HOME/dotfiles/dotfiles\.sh" $HOME/.zshrc; then
  print_run "Sourcing dotfiles in \$HOME/.zshrc file (skipped)"
else
  print_run "Sourcing dotfiles in \$HOME/.zshrc file"
  echo 'source $HOME/dotfiles/dotfiles.sh' >>$HOME/.zshrc
fi

# --- Create symlinks using GNU Stow ---
# save current working directory
cwd=$(pwd)

# Changing to $HOME/dotfiles directory
cd $HOME/dotfiles

print_run "Creating symlinks using GNU Stow"
stow .

# go back to current working directory
cd $cwd

# -- Install Node v22
if fnm list | grep -q v22; then
  print_run "Installing Node v22 (skipped)"
else
  print_run "Installing Node v22"
  fnm install 22
  fnm default 22
fi

# --- macOS specific installations ---
if [[ "$(uname -s)" == "Darwin" ]]; then
  source $HOME/dotfiles/install_macOS.sh
elif [[ "$(uname -s)" == "Linux" ]]; then
  source $HOME/dotfiles/install_linux.sh
fi
