# Home directory paths
export XDG_CONFIG_HOME="$HOME/.config"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"
export GNUPGHOME="$HOME/.local/share/gnupg"

# Options
export EDITOR=nvim

setup_zsh_autocomplete() {
  local autocomplete_dir="$HOME/.local/share/zsh-autocomplete"

  setopt interactive_comments

  bindkey -e

  if [[ -f "$autocomplete_dir/zsh-autocomplete.plugin.zsh" ]]; then
    source "$autocomplete_dir/zsh-autocomplete.plugin.zsh"
  fi
}

setup_starship() {
  if ! command -v starship >/dev/null 2>&1; then
    return
  fi

  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
  eval "$(starship init zsh)"
}

setup_mise() {
  if ! command -v mise >/dev/null 2>&1; then
    return
  fi

  eval "$(mise activate zsh)"
}

setup_zoxide() {
  if ! command -v zoxide >/dev/null 2>&1; then
    return
  fi

  eval "$(zoxide init zsh)"
}

main() {
  setup_mise
  setup_zsh_autocomplete
  setup_starship
  setup_zoxide
}

main "$@"

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons --time-style='+%D %r'"
fi

o() {
  if ! command -v sesh >/dev/null 2>&1 || ! command -v fzf >/dev/null 2>&1 || ! command -v tmux >/dev/null 2>&1; then
    echo "o requires sesh, fzf, and tmux"
    return 1
  fi

  sesh connect "$(
    sesh list --icons --hide-duplicates | fzf --no-border \
      --ansi \
      --list-border \
      --no-sort --prompt '⚡ ' \
      --color 'list-border:6,input-border:3,preview-border:4,header-bg:-1,header-border:6' \
      --input-border \
      --header-border \
      --bind 'ctrl-a:change-prompt(⚡ )+reload(sesh list --icons)' \
      --bind 'ctrl-g:change-prompt(  )+reload(sesh list --icons --config)' \
      --bind 'ctrl-t:change-prompt(  )+reload(sesh list --icons --tmux)' \
      --bind 'ctrl-f:change-prompt(  )+reload(sesh list --icons --zoxide)' \
      --bind 'ctrl-d:execute(tmux kill-session -t {2..})+change-prompt(⚡ )+reload(sesh list --tmux --icons)' \
      --preview-window 'right:75%' \
      --preview 'sesh preview {}'
  )"
}
