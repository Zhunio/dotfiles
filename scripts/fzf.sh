# Setup fzf
source <(fzf --zsh)
# Options to fzf command
export FZF_DEFAULT_OPTS='
--prompt=" "
--pointer=" "
--marker=""
--info=inline
--height=~100%
--color=bg+:#011627
--color=pointer:#a6e3a1
--color=marker:#a6e3a1'

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    cht.sh)       cht.sh :list | fzf                        \
                    --preview 'cht.sh {1}'                  \
                    --preview-window=top,80%,border-none  "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}'  \
                    --preview-window=top,80%,border-none  "$@" ;;
  esac
}

