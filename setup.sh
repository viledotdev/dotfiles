#!/usr/bin/env bash
set -Eeuo pipefail

# --- rutas base (sin realpath) ---
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$SCRIPT_DIR"

# --- cargar módulos ---
source "$DOTFILES_DIR/_setup/lib/pkg.sh"
source "$DOTFILES_DIR/_setup/lib/shell.sh"
source "$DOTFILES_DIR/_setup/lib/fs.sh"
source "$DOTFILES_DIR/_setup/lib/apps.sh"
source "$DOTFILES_DIR/_setup/lib/yaml_install.sh"

main() {
  PACKAGE_MANAGER="$(detect_package_manager)"

  ensure_zsh_shell "$@"

  install_all_apps

  link_zshrc
  link_config_folders
  install_from_yaml "$@"

  echo "✅ Setup complete! Restart your terminal."
}

main "$@"
