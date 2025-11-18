# brew
source $HOME/dotfiles/dotfiles_brew.sh
# oh-my-zsh
source $HOME/dotfiles/dotfiles_oh-my-zsh.sh
# starship
export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
eval "$(starship init zsh)"
# fzf
source $HOME/dotfiles/dotfiles_fzf.sh
# fnm
eval "$(fnm env --use-on-cd --shell zsh)"
# fnm bash_completion
eval "$(fnm completions --shell zsh)"
# zoxide
eval "$(zoxide init zsh)"
# Add the latest Homebrew Git bin directory to PATH if it exists
git=$(brew --prefix git)/bin
if [[ -d "$git" ]]; then
  export PATH="$git_dir:$PATH"
fi

