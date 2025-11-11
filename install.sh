#!/bin/bash

# Colors for output
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# --- Clone dotfiles repository ---
if [[ -d $HOME/dotfiles ]]; then
  echo -e "${BLUE}==>${RESET} Cloning https://github.com/Zhunio/dotfiles.git ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Cloning https://github.com/Zhunio/dotfiles.git${RESET}"
  git clone https://github.com/Zhunio/dotfiles.git $HOME/dotfiles
fi

# --- Install Oh My Zsh ---
export KEEP_ZSHRC=yes

if [[ -d $ZSH ]]; then
  echo -e "${BLUE}==>${RESET} Installing Oh My Zsh ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Installing Oh My Zsh${RESET}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- Install Homebrew ---
export NONINTERACTIVE=1

if command -v brew >/dev/null 2>&1; then
  echo -e "${BLUE}==>${RESET} Installing Homebrew ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Installing Homebrew${RESET}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  source $HOME/dotfiles/dotfiles_brew.sh
fi

# -- Update Homebrew ---
brew update

# --- Homebrew packages ---
packages=(
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
  "ripgrep"
  "stow"
  "tmux"
  "terraform"
  "zoxide"
  "zsh-autocomplete"
  "starship"
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
  echo -e "${BLUE}==>${RESET} Sourcing dotfiles in \$HOME/.zshrc file. ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Sourcing dotfiles in \$HOME/.zshrc file...${RESET}"
  echo 'source $HOME/dotfiles/dotfiles.sh' >>$HOME/.zshrc
fi

# --- Create symlinks using GNU Stow ---
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

# -- Install Node v22
if fnm list | grep -q v22; then
  echo -e "${BLUE}==>${RESET} Installing Node v22 ${BOLD}(skipped)${RESET}"
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Installing Node v22${RESET}"
  fnm install 22
  fnm default 22
fi

# --- macOS specific installations ---
if [[ "$(uname -s)" == "Darwin" ]]; then
  source $HOME/dotfiles/install_macOS.sh
elif [[ "$(uname -s)" == "Linux" ]]; then
  source $HOME/dotfiles/install_linux.sh
fi
