# Este archivo se source-a desde setup.sh (no necesita shebang)
set -Eeuo pipefail

detect_package_manager() {
  if command -v brew &> /dev/null; then
    echo "brew"
  elif command -v apt &> /dev/null; then
    echo "apt"
  elif command -v pacman &> /dev/null; then
    echo "pacman"
  else
    echo "❌ No compatible package manager found." >&2
    exit 1
  fi
}

install_package() {
  local app="$1"
  case "$PACKAGE_MANAGER" in
    brew)
      brew_install "$app"
      ;;
    apt)
      sudo apt update
      sudo apt install -y "$app"
      ;;
    pacman)
      sudo pacman -Sy --noconfirm "$app"
      ;;
    *)
      echo "❌ Unsupported package manager: $PACKAGE_MANAGER" >&2
      exit 1
      ;;
  esac
}

brew_install() {
  local app="$1"
  if ! brew install "$app"; then
    brew install --cask "$app"
  fi
}

install_if_missing() {
  local app="$1"
  if ! command -v "$app" &> /dev/null; then
    echo "Installing $app..."
    install_package "$app"
  else
    echo "$app already installed."
  fi
}
