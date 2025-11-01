#!/bin/bash

BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# Create $HOME/bin folder if it doesn't exist
if [[ -d $HOME/bin ]]; then
  echo -e "${BLUE}==>${RESET} Creating \$HOME/bin folder ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Creating \$HOME/bin folder${RESET}"
  mkdir $HOME/bin
fi

# OH MY ZSH installation path
export ZSH="$HOME/bin/.oh-my-zsh"
# Keep existing .zshrc file
export KEEP_ZSHRC=yes

# Install Oh My Zsh
if [[ -d $ZSH ]]; then
  echo -e "${BLUE}==>${RESET} Installing Oh My Zsh ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Installing Oh My Zsh...${RESET}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Update Homebrew
# brew update

# List of Homebrew packages
packages=(
  "bat"
  "btop"
  "fd"
  "fzf"
  "fnm"
  "git"
  "gh"
  "go"
  "jq"
  "neovim"
  "ripgrep"
  "stow"
  "tmux"
  "zoxide"
  "zsh-autocomplete"
  "oh-my-posh"
  "koekeishiya/formulae/skhd"
  "koekeishiya/formulae/yabai"
  "sdkman/tap/sdkman-cli"
  "tlk/imagemagick-x11/imagemagick"
)

# Install packages
# for package in "${packages[@]}"; do
#   brew install "$package"
# done

casks=(
  "1password-cli"
  "xquartz"
  "ghostty"
  "visual-studio-code"
  "raycast"
  "shottr"
  "font-meslo-lg-nerd-font"
)

# Install casks
# for cask in "${casks[@]}"; do
#   brew install --cask "$cask"
# done

# Source dotfiles
echo ""
if grep -q "source \$HOME/dotfiles\.sh" $HOME/.zshrc; then
  echo -e "${BLUE}==>${RESET} Sourcing dotfiles in \$HOME/.zshrc file. ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Sourcing dotfiles in \$HOME/.zshrc file...${RESET}"
  echo 'source $HOME/dotfiles.sh' >>$HOME/.zshrc
fi

# Use GNU Stow to create symlinks
if [[ -d $HOME/.config ]]; then
  echo -e "${BLUE}==>${RESET} Creating symlinks using GNU Stow ${BOLD}(skipped)${RESET}"
else
  # save current working directory
  cwd=$(pwd)

  # Changing to $HOME/dotfiles directory
  cd $HOME/dotfiles

  echo -e "${BLUE}==>${RESET} ${BOLD}Creating symlinks using GNU Stow${RESET}"
  stow .

  # go back to current working directory
  cd $cwd
fi

# Install Java 21 & Gradle via sdkman
if brew list | grep -q 'sdkman'; then
  echo -e "${BLUE}==>${RESET} ${BOLD}Installing Java 21 & Gradle via sdkman${RESET}"

  # Source sdkman so we can access execute following commands
  export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
  source "${SDKMAN_DIR}/bin/sdkman-init.sh"

  sdk install java 21.0.6-oracle
  sdk install gradle 9.0.0

  echo ""
fi

# Prompt to install Tmux Plugin Manager
if [[ -d $HOME/bin/tmux-plugins/tpm ]]; then
  echo -e "${BLUE}==>${RESET} Installing Tmux Plugin Manager ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Installing Tmux Plugin Manager${RESET}"
  git clone https://github.com/tmux-plugins/tpm $HOME/bin/tmux-plugins/tpm

  echo "Running Tmux Plugin Manager Install script"
  $HOME/bin/tmux-plugins/tpm/scripts/install_plugins.sh
fi

# Prompt to start yabai service
if pgrep -x yabai >/dev/null; then
  echo -e "${BLUE}==>${RESET} ${BOLD}Restarting yabai service${RESET}"
  yabai --restart-service
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Starting yabai service${RESET}"
  yabai --start-service
fi

# Prompt to start skhd service
if pgrep -x skhd >/dev/null; then
  echo -e "${BLUE}==>${RESET} ${BOLD}Restarting skhd service${RESET}"
  skhd --restart-service
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Starting skhd service${RESET}"
  skhd --start-service
fi
