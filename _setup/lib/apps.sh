# Se source-a desde setup.sh
set -Eeuo pipefail

install_all_apps() {
  for folder in "$DOTFILES_DIR"/*/; do
    local app
    app="$(basename "$folder")"
    [[ $app =~ ^_ ]] && continue
    install_if_missing "$app" # <-- bug corregido (antes pasaba 'app' literal)
  done
}
