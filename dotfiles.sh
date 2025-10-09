# oh-my-zsh
source $HOME/dotfiles/dotfiles_oh-my-zsh.sh
# fzf
source $HOME/dotfiles/dotfiles_fzf.sh
# nvm
source $HOMEBREW_PREFIX/opt/nvm/nvm.sh
# nvm bash_completion
source $HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm
# sdkman
source $HOME/.sdkman/bin/sdkman-init.sh
# zoxide
eval "$(zoxide init zsh)"
# oh-my-posh theme
eval "$(oh-my-posh init zsh --config $HOME/dotfiles/themes/oh-my-posh-theme.json)"

# Add the latest Homebrew Git bin directory to PATH if it exists
git_dir=$(echo /usr/local/Cellar/git/*/bin | awk '{print $1}')
if [[ -d "$git_dir" ]]; then
  export PATH="$git_dir:$PATH"
fi
