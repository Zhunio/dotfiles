opget() {
  op item list | fzf | awk '{print $1}' | xargs -r op item get --reveal
}
