# macOS-only packages
macOS_packages=(
  "asmvik/formulae/skhd"
  "asmvik/formulae/yabai"
)

# macOS-only casks
macOS_casks=(
  "xquartz"
  "ghostty"
  "visual-studio-code"
  "raycast"
  "shottr"
)

for package in "${macOS_packages[@]}"; do
  brew install "$package"
done

for cask in "${macOS_casks[@]}"; do
  brew install --cask "$cask"
done

# Prompt to start yabai service
if pgrep -x yabai >/dev/null; then
  echo -e "${BLUE}==>${RESET} ${BOLD}Restarting yabai service${RESET}"
  yabai --restart-service
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Starting yabai service${RESET}"
  yabai --start-service
fi

# Prompt to start skhd service
if pgrep -x skhd >/dev/null; then
  echo -e "${BLUE}==>${RESET} ${BOLD}Restarting skhd service${RESET}"
  skhd --restart-service
else
  echo -e "${BLUE}==>${RESET} ${BOLD}Starting skhd service${RESET}"
  skhd --start-service
fi
