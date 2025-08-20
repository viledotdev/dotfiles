set -Eeuo pipefail

ensure_yq() {
  if command -v yq > /dev/null 2>&1; then
    return 0
  fi
  echo "❌ yq is required to read config/apps.yaml. Please install yq and re-run." >&2
  exit 1
}

list_yaml_categories() {
  local apps_file="$DOTFILES_DIR/config/apps.yaml"
  [[ -f $apps_file ]] || return 0
  yq -r '.apps | keys[]' "$apps_file"
}

_install_names_from_yaml() {
  local apps_file="$DOTFILES_DIR/config/apps.yaml"
  local pm="$PACKAGE_MANAGER"

  if [[ $# -eq 0 ]]; then
    yq -r --arg pm "$pm" '
      .apps
      | to_entries
      | .[].value[]
      | if type == "string" then .
        else ( .[$pm] // .name // . )
        end
    ' "$apps_file"
  else
    local cat
    for cat in "$@"; do
      yq -r --arg cat "$cat" --arg pm "$pm" '
        .apps[$cat][]?
        | select(. != null)
        | if type == "string" then .
          else ( .[$pm] // .name // . )
          end
      ' "$apps_file"
    done
  fi
}

install_from_yaml() {
  local apps_file="$DOTFILES_DIR/config/apps.yaml"
  if [[ ! -f $apps_file ]]; then
    echo "ℹ️  No apps.yaml at $apps_file (skipping YAML installs)"
    return 0
  fi
  ensure_yq

  local names
  names="$(_install_names_from_yaml "$@")"
  if [[ -z $names ]]; then
    echo "ℹ️  No apps resolved from apps.yaml for categories: ${*:-ALL}"
    return 0
  fi

  echo "$names" \
    | grep -vE '^\s*$' \
    | grep -vE '^\s*#' \
    | awk '!seen[$0]++' \
    | while IFS= read -r app; do
      install_if_missing "$app"
    done
}
