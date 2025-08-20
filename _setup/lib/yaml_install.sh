ensure_yq() {
  command -v yq > /dev/null 2>&1 && return 0
  echo "❌ yq is required (e.g., brew install yq)" >&2
  exit 1
}

_yaml_all_for_pm() {
  local apps_file="$DOTFILES_DIR/config/apps.yaml"
  PM="$PACKAGE_MANAGER" yq -r '
    .apps
    | to_entries
    | .[].value[]
    | if type == "string" then .
      else ( .[env(PM)] // .all // .name // empty )
      end
    | select(. != null)
  ' "$apps_file"
}

_yaml_cat_for_pm() {
  local apps_file="$DOTFILES_DIR/config/apps.yaml" cat="$1"
  PM="$PACKAGE_MANAGER" CAT="$cat" yq -r '
    .apps[env(CAT)][]?
    | if type == "string" then .
      else ( .[env(PM)] // .all // .name // empty )
      end
    | select(. != null)
  ' "$apps_file"
}

list_yaml_categories() {
  local apps_file="$DOTFILES_DIR/_setup/apps.yaml"
  [[ -f $apps_file ]] || return 0
  yq -r '.apps | keys[]' "$apps_file"
}

install_from_yaml() {
  local apps_file="$DOTFILES_DIR/_setup/apps.yaml"
  [[ -f $apps_file ]] || {
    echo "ℹ️  No apps.yaml at $apps_file (skipping)"
    return 0
  }
  ensure_yq

  local items=""
  if [[ $# -eq 0 ]]; then
    items="$(_yaml_all_for_pm)"
  else
    while [[ $# -gt 0 ]]; do
      items+="$(_yaml_cat_for_pm "$1")"$'\n'
      shift
    done
  fi

  # dedupe y decisión simple: para brew si parece tap/cask (tiene '/'), instala directo;
  # en demás casos usa install_if_missing (que chequea binario).
  echo "$items" | grep -vE '^\s*$' | awk '!seen[$0]++' \
    | while IFS= read -r pkg; do
      if [[ $PACKAGE_MANAGER == "brew" && $pkg == */* ]]; then
        echo "Installing (brew tap/cask) $pkg ..."
        install_package "$pkg"
      else
        install_if_missing "$pkg"
      fi
    done
}
