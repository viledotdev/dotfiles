#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Development/dotfiles}"
TEMPLATES_DIR="$DOTFILES_DIR/_templates/linter"

FORCE=0
TYPE=""

usage() {
  cat << 'EOF'
init_linter --type <vanilla-ts|node-ts|react|vue|vanilla-js> [--force]

Copies templates into the current directory:
  - eslint.config.js (includes ignores for flat config)

Examples:
  init_linter --type vanilla-ts
  init_linter --type node-ts
  init_linter --type react --force
  init_linter --type vue
  init_linter --type vanilla-js
EOF
}

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --type)
      TYPE="${2:-}"
      shift 2
      ;;
    --force | -f)
      FORCE=1
      shift
      ;;
    -h | --help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown arg: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ -z $TYPE ]]; then
  echo "Missing --type"
  usage
  exit 1
fi

# Pick template
SRC=""
case "$TYPE" in
  vanilla-ts) SRC="$TEMPLATES_DIR/vanilla-ts.eslint.config.js" ;;
  node-ts) SRC="$TEMPLATES_DIR/node-ts.eslint.config.js" ;;
  react) SRC="$TEMPLATES_DIR/react.eslint.config.js" ;;
  vue) SRC="$TEMPLATES_DIR/vue.eslint.config.js" ;;
  vanilla-js) SRC="$TEMPLATES_DIR/vanilla-js.eslint.config.js" ;;
  *)
    echo "Invalid --type: $TYPE"
    usage
    exit 1
    ;;
esac

DEST="./eslint.config.js"

copy_one() {
  local src="$1"
  local dest="$2"

  if [[ ! -f $src ]]; then
    echo "✗ Missing template: $src"
    exit 1
  fi

  if [[ -f $dest && $FORCE -ne 1 ]]; then
    echo "• Skipping (exists): $dest"
    return 0
  fi

  cp -f "$src" "$dest"
  echo "✓ Copied: $dest"
}

copy_one "$SRC" "$DEST"

echo "Done. (type=$TYPE)"
