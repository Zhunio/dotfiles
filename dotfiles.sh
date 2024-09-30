# oh-my-zsh
source $HOME/dotfiles/scripts/oh-my-zsh.sh
# fzf
source $HOME/dotfiles/scripts/fzf.sh
# nvm
source $HOME/.nvm/nvm.sh
# nvm bash_completion
source $HOME/.nvm/bash_completion
# sdkman
source $HOME/.sdkman/bin/sdkman-init.sh
# zoxide
eval "$(zoxide init zsh)"
# oh-my-posh theme
eval "$(oh-my-posh init zsh --config $HOME/dotfiles/themes/oh-my-posh-theme.json)"
