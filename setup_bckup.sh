#!/bin/bash

set -e

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
      brew install "$app"
      ;;
    apt)
      sudo apt update
      sudo apt install -y "$app"
      ;;
    pacman)
      sudo pacman -Sy --noconfirm "$app"
      ;;
    *)
      echo "❌ Unsupported package manager: $PACKAGE_MANAGER"
      exit 1
      ;;
  esac
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

ensure_zsh_shell() {
  if [ "$(basename -- "$SHELL")" != "zsh" ]; then
    echo "⚠️ Not running in zsh. Switching..."

    install_if_missing zsh

    if ! grep -q "$(command -v zsh)" /etc/shells; then
      echo "Adding $(command -v zsh) to /etc/shells"
      echo "$(command -v zsh)" | sudo tee -a /etc/shells
    fi

    echo "Changing default shell to zsh..."
    chsh -s "$(command -v zsh)"

    echo "Re-running script with zsh..."
    exec zsh "$0" "$@"
    exit 0
  fi
}

create_symlink() {
  local target="$1"
  local link="$2"

  if [ -L "$link" ] || [ -e "$link" ]; then
    echo "Skipping symlink creation: $link already exists"
  else
    ln -s "$target" "$link"
    echo "Symlink done: $link -> $target"
  fi
}

link_zshrc() {
  create_symlink "$DOTFILES_DIR/_zsh/init.zsh" "$HOME/.zshrc"
}
install_all_apps() {
  for folder in "$DOTFILES_DIR"/*/; do
    local app=$(basename "$folder")
    [[ $app =~ ^_ ]] && continue
    install_if_missing app
  done
}
link_config_folders() {
  for folder in "$DOTFILES_DIR"/*/; do
    local app=$(basename "$folder")
    [[ $app =~ ^_ ]] && continue
    create_symlink "$folder" "$HOME/.config/$app"
  done
}

### --- MAIN EXECUTION ---
DOTFILES_DIR="$(realpath "$(dirname "$0")")"
PACKAGE_MANAGER=$(detect_package_manager)

install_if_missing sudo
ensure_zsh_shell

install_all_apps

link_zshrc
link_config_folders

echo "✅ Setup complete! Restart your terminal."
