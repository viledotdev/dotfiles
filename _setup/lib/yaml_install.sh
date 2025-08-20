ensure_yq() {
  command -v yq > /dev/null 2>&1 || {
    echo "❌ yq is required (e.g., brew install yq)" >&2
    exit 1
  }
}

_yaml_all_for_pm() {
  local apps_file="$DOTFILES_DIR/_setup/apps.yaml"
  PM="$PACKAGE_MANAGER" yq -r '
    .apps[] | (.[env(PM)] // .) | select(. != null)
  ' "$apps_file"
}

install_from_yaml() {
  local apps_file="$DOTFILES_DIR/_setup/apps.yaml"
  [[ -f $apps_file ]] || {
    echo "ℹ️  No apps.yaml at $apps_file (skipping)"
    return 0
  }
  ensure_yq

  _yaml_all_for_pm | grep -vE '^\s*$' | awk '!seen[$0]++' \
    | while IFS= read -r pkg; do
      if [[ $PACKAGE_MANAGER == "brew" && $pkg == */* ]]; then
        echo "Installing (brew tap/cask) $pkg ..."
        install_package "$pkg"
      else
        install_if_missing "$pkg"
      fi
    done
}
