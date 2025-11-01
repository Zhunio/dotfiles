os="$(uname -s)"
arch="$(uname -m)"

# macOS Apple Silicon
if [[ "$os" == "Darwin" && "$arch" == "arm64" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
# macOS Intel
elif [[ "$os" == "Darwin" && "$arch" == "x86_64" ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
# WSL/Linux
elif [[ "$os" == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
