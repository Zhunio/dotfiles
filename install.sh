#!/bin/bash

# save current working directory
cwd=$(pwd)

# Changing to $HOME/dotfiles directory
cd $HOME/dotfiles

# Install Brewfile
echo ""
echo "Installing Brew dependencies..."
brew bundle install

# Use GNU Stow to create symlinks
echo ""
read -p 'Do you want to use GNU Stow to create symlinks? [Y/n]' -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  echo "Creating symlinks using GNU Stow..."
  stow .
fi

# go back to current working directory
cd $cwd

# Install nvm
echo ""
read -p 'Do you want to install nvm? [Y/n]' -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  if [[ -d $HOME/.nvm ]]; then
    echo 'Installing nvm (skipped) since nvm is already installed'
  else
    echo 'Installing nvm...'
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
  fi
fi

# Install sdkman
echo ""
read -p 'Do you want to install sdkman? [Y/n]' -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  if [[ -d $HOME/.sdkman ]]; then
    echo 'Installing sdkman (skipped) since sdkman is already installed'
  else
    echo 'Installing sdkman...'
    curl -s "https://get.sdkman.io" | bash
  fi

  # Source sdkman so we can access `sdk` command
  source $HOME/.sdkman/bin/sdkman-init.sh

  # Istall Java versions: 17, 21
  sdk install java 17.0.12-oracle
  sdk install java 21.0.6-oracle

  # Install maven
  sdk install maven 3.9.9

  sdk default java 21.0.6-oracle
fi

# Source dotfiles
echo ""
read -p 'Do you want to source dotfiles in the $HOME/.zshrc file? [Y/n] ' -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  echo 'Sourcing dotfiles in $HOME/.zshrc file...'
  echo 'source $HOME/dotfiles.sh' >>$HOME/.zshrc
fi

# Prompt to add bin folder
echo ""
read -p 'Do you want to add $HOME/bin folder? [Y/n]' -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  if [[ -d $HOME/bin ]]; then
    echo 'Creating $HOME/bin folder (skipped) since it already exists'
  else
    echo 'Creating $HOME/bin folder...'
    mkdir $HOME/bin
  fi
fi

# Prompt to install Tmux Plugin Manager
echo ""
read -p "Do you want to install Tmux Plugin Manager? [Y/n] " -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  if [[ -d $HOME/bin/tmux-plugins/tpm ]]; then
    echo "Installing Tmux Plugin Manager (skipped) since it is already installed"
  else
    echo "Installing Tmux Plugin Manager..."
    git clone https://github.com/tmux-plugins/tpm $HOME/bin/tmux-plugins/tpm
  fi

  echo ""
  echo "Running Tmux Plugin Manager Install script..."
  $HOME/bin/tmux-plugins/tpm/scripts/install_plugins.sh
fi

# Prompt to start yabai service
echo ""
read -p "Do you want to start yabai service? [Y/n] " -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  echo "Starting yabai service..."
  yabai --start-service
fi

# Prompt to start skhd service
echo ""
read -p "Do you want to start skhd service? [Y/n] " -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  echo "Starting skhd service..."
  skhd --start-service
fi
