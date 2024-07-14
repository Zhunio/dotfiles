# save current working directory
cwd=$(pwd)

# Changing to $HOME/dotfiles directory
cd $HOME/dotfiles

# Uninstalling dotfiles
echo "Uninstalling dotfiles..."
stow -D .

# go back to current working directory
cd $cwd

