# save current working directory
cwd=$(pwd)

# Changing to $HOME/dotfiles directory
cd $HOME/dotfiles

# Uninstalling dotfiles
echo "Uninstalling dotfiles..."

# Use GNU Stow to undo the symlinks
echo "Use GNU Stow to undo the symlinks..."
stow -D .

# go back to current working directory
cd $cwd

