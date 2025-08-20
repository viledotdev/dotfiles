detect_package_manager() {
  if command -v brew > /dev/null 2>&1; then
    echo "brew"
  elif command -v apt > /dev/null 2>&1; then
    echo "apt"
  elif command -v pacman > /dev/null 2>&1; then
    echo "pacman"
  else
    echo "❌ No compatible package manager found (brew/apt/pacman)." >&2
    exit 1
  fi
}

brew_tap_exists() {
  local tap="$1"
  brew tap | grep -qx "$tap"
}

ensure_brew_tap() {
  local spec="$1" tap
  case "$spec" in
    */*/*)
      tap="$(printf '%s' "$spec" | cut -d/ -f1-2)"
      if ! brew_tap_exists "$tap"; then
        echo "👉 brew tap $tap"
        brew tap "$tap"
      fi
      ;;
    *)
      : # no hay tap que asegurar
      ;;
  esac
}

brew_install() {
  local app="$1"
  case "$app" in
    */*/*) ensure_brew_tap "$app" ;;
  esac

  if ! brew install "$app"; then
    brew install --cask "$app"
  fi
}

install_package() {
  local app="$1"
  case "$PACKAGE_MANAGER" in
    brew)
      brew update > /dev/null 2>&1 || true
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
      echo "❌ Unsupported PM: $PACKAGE_MANAGER" >&2
      return 1
      ;;
  esac
}

install_if_missing() {
  local app="$1"
  if command -v "$app" > /dev/null 2>&1; then
    echo "$app already installed."
    return 0
  fi
  echo "Installing $app..."
  install_package "$app"
}
