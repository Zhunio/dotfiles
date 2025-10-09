#!/bin/bash

# save current working directory
cwd=$(pwd)

# Changing to $HOME/dotfiles directory
cd $HOME/dotfiles

# Install Brewfile
echo "1. Installing Brew dependencies"
echo ""
brew bundle install
echo ""

# Use GNU Stow to create symlinks
if [[ -d $HOME/.config ]]; then
  echo "2. Creating symlinks using GNU Stow (skipped)"
else
  echo "2. Creating symlinks using GNU Stow"
  stow .
fi

# go back to current working directory
cd $cwd

# Install sdkman
if [[ -d $HOME/.sdkman ]]; then
  echo '3. Installing sdkman (skipped)'
else
  echo '3. Installing sdkman'
  curl -s "https://get.sdkman.io" | bash

  # Source sdkman so we can access execute following commands
  source $HOME/.sdkman/bin/sdkman-init.sh

  # Istall Java versions: 17, 21
  sdk install java 17.0.12-oracle
  sdk install java 21.0.6-oracle

  sdk install maven 3.9.10
  sdk install gradle 9.0.0

  sdk default java 21.0.6-oracle
fi

# Source dotfiles
if grep -q "source \$HOME/dotfiles\.sh" $HOME/.zshrc; then
  echo '4. Sourcing dotfiles in $HOME/.zshrc file (skipped)'
else
  echo '4. Sourcing dotfiles in $HOME/.zshrc file...'
  echo 'source $HOME/dotfiles.sh' >>$HOME/.zshrc
fi

# Prompt to add bin folder
if [[ -d $HOME/bin ]]; then
  echo '5. Creating $HOME/bin folder (skipped)'
else
  echo '5. Creating $HOME/bin folder...'
  mkdir $HOME/bin
fi

# Prompt to install Tmux Plugin Manager
if [[ -d $HOME/bin/tmux-plugins/tpm ]]; then
  echo "6. Installing Tmux Plugin Manager (skipped)"
else
  echo "6. Installing Tmux Plugin Manager"
  git clone https://github.com/tmux-plugins/tpm $HOME/bin/tmux-plugins/tpm

  echo "6.1 Running Tmux Plugin Manager Install script"
  $HOME/bin/tmux-plugins/tpm/scripts/install_plugins.sh
fi

# Prompt to start yabai service
if pgrep -x yabai >/dev/null; then
  echo "7. Restarting yabai service"
  yabai --restart-service
else
  echo "7. Starting yabai service"
  yabai --start-service
fi

# Prompt to start skhd service
if pgrep -x skhd >/dev/null; then
  echo "8. Restarting skhd service"
  skhd --restart-service
else
  echo "8. Starting skhd service"
  skhd --start-service
fi
