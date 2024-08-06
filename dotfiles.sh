# Configuration for oh-my-zsh
source $HOME/dotfiles/scripts/oh-my-zsh.sh

# Configuration for fzf
source $HOME/dotfiles/scripts/fzf.sh

# Path for oh-my-posh theme
eval "$(oh-my-posh init zsh --config $HOME/dotfiles/themes/oh-my-posh-theme.json)"

# Path for nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(zoxide init zsh)"
