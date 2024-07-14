#!/bin/bash

# Clone https://github.com/Zhunio/dotfiles repository
if [[ ! -d $HOME/dotfiles ]]; then
  git clone https://github.com/Zhunio/dotfiles $HOME/dotfiles
  echo ""
fi

# Changing to $HOME/dotfiles directory
cd $HOME/dotfiles

# Install Brewfile
echo "Installing Brew dependencies..."
brew bundle install

# Use GNU Stow to create symlinks
echo ""
echo "Creating symlinks using GNU Stow..."
stow .

# Source dotfiles
echo ""
read -p 'Do you want to source dotfiles in the $HOME/.zshrc file? [Y/n] ' -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  echo 'Sourcing dotfiles in $HOME/.zshrc file...'
  echo 'source $HOME/dotfiles.sh' >> $HOME/.zshrc
fi

# Prompt to install Tmux Plugin Manager
echo ""
read -p "Do you want to install Tmux Plugin Manager? [Y/n] " -n 1 -r yesNo
if [[ $yesNo =~ ^[Yy]$ ]]; then
  echo ""
  echo "Installing Tmux Plugin Manager..."
  if [[ ! -d $HOME/bin/tmux-plugins/tpm  ]]; then
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
