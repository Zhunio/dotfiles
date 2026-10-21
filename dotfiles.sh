# Home directory paths
export XDG_CONFIG_HOME="$HOME/.config"
export NPM_CONFIG_CACHE="$HOME/.cache/npm"
export GNUPGHOME="$HOME/.local/share/gnupg"

# Options
export EDITOR=nvim

setup_homebrew() {
  [[ "$(uname -s)" == Darwin ]] || return 0

  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

setup_zsh_autocomplete() {
  local plugin_path

  setopt interactive_comments

  bindkey -e

  case "$(uname -s)" in
    Darwin) plugin_path="$HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ;;
    Linux) plugin_path="$HOME/.local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh" ;;
    *) return ;;
  esac

  if [[ -f "$plugin_path" ]]; then
    source "$plugin_path"
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

setup_git_path() {
  local git_bin

  if ! command -v brew >/dev/null 2>&1; then
    return
  fi

  git_bin="$(brew --prefix git)/bin"

  if [[ -d "$git_bin" ]]; then
    export PATH="$git_bin:$PATH"
  fi
}

main() {
  setup_homebrew
  setup_mise
  setup_zsh_autocomplete
  setup_starship
  setup_zoxide
  setup_git_path
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
