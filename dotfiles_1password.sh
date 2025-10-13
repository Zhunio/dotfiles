opfzf() {
  op item list | fzf | awk '{print $1}' | xargs -r op item get --reveal
}

opfind() {
  search_term="$1"

  if [ -z "$search_term" ]; then
    echo "Usage: opfind <search_term>"
    return 1
  fi

  for id in $(op item list | grep -i "$1" | awk '{print $1}'); do
    op item get "$id" --reveal
  done
}
