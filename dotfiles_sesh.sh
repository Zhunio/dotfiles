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
