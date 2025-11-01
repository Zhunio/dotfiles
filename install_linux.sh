linux_packages=(
  "python"
)

for package in "${linux_packages[@]}"; do
  brew install "$package"
done
