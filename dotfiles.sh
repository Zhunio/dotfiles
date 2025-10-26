# oh-my-zsh
source $HOME/dotfiles/dotfiles_oh-my-zsh.sh
# fzf
source $HOME/dotfiles/dotfiles_fzf.sh
# 1Password
source $HOME/dotfiles/dotfiles_1password.sh
# fnm
eval "$(fnm env --use-on-cd --shell zsh)"
# fnm bash_completion
eval "$(fnm completions --shell zsh)"
# sdkman
export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
source "${SDKMAN_DIR}/bin/sdkman-init.sh"
# zoxide
eval "$(zoxide init zsh)"
# oh-my-posh theme
eval "$(oh-my-posh init zsh --config $HOME/dotfiles/themes/oh-my-posh-theme.json)"

# add bin to path
if [[ -s $HOME/bin ]]; then
  export PATH="$PATH:$HOME/bin"
fi

# Add the latest Homebrew Git bin directory to PATH if it exists
git_dir=$(echo /usr/local/Cellar/git/*/bin | awk '{print $1}')
if [[ -d "$git_dir" ]]; then
  export PATH="$git_dir:$PATH"
fi

# DYLD_FALLBACK_LIBRARY_PATH for imagemagick
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"
