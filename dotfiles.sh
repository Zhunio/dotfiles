export XDG_CONFIG_HOME="$HOME/.config"

setup_homebrew() {
  local os arch
  os="$(uname -s)"
  arch="$(uname -m)"

  if [[ "$os" == "Darwin" && "$arch" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ "$os" == "Darwin" && "$arch" == "x86_64" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  elif [[ "$os" == "Linux" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi
}

setup_zsh_autocomplete() {
  source "$HOMEBREW_PREFIX/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
}

setup_starship() {
  export STARSHIP_CONFIG=$HOME/.config/starship/starship.toml
  eval "$(starship init zsh)"
}

setup_mise() {
  eval "$(mise activate zsh)"
}

setup_zoxide() {
  eval "$(zoxide init zsh)"
}

setup_git_path() {
  local git_bin
  git_bin="$(brew --prefix git)/bin"

  if [[ -d "$git_bin" ]]; then
    export PATH="$git_bin:$PATH"
  fi
}

main() {
  setup_homebrew
  setup_zsh_autocomplete
  setup_starship
  setup_mise
  setup_zoxide
  setup_git_path
}

main "$@"

alias ls="eza --icons --time-style='+%D %r'"

o() {
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
      --preview-window 'right:55%' \
      --preview 'sesh preview {}'
  )"
}
