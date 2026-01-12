#!/usr/bin/env bash
set -euo pipefail

FORCE=0
if [[ ${1:-} == "--force" || ${1:-} == "-f" ]]; then
  FORCE=1
fi

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Development/dotfiles}"
TEMPLATES_DIR="$DOTFILES_DIR/_templates/formatter"

copy_one() {
  local src="$1"
  local dest="./$(basename "$src")"

  if [[ ! -f $src ]]; then
    echo "✗ Missing template: $src"
    exit 1
  fi

  if [[ -f $dest && $FORCE -ne 1 ]]; then
    echo "• Skipping (exists): $dest"
    return 0
  fi

  cp -f "$src" "$dest"
  echo "✓ Copied: $(basename "$src")"
}

copy_one "$TEMPLATES_DIR/.prettierrc"
copy_one "$TEMPLATES_DIR/.prettierignore"

echo "Done."
