# Se source-a desde setup.sh
set -Eeuo pipefail

create_symlink() {
  local target="$1"
  local link="$2"

  mkdir -p "$(dirname "$link")"
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

link_config_folders() {
  mkdir -p "$HOME/.config"
  for folder in "$DOTFILES_DIR"/*/; do
    local app
    app="$(basename "$folder")"
    [[ $app =~ ^_ ]] && continue
    create_symlink "$folder" "$HOME/.config/$app"
  done
}
