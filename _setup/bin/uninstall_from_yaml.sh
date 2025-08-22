#!/usr/bin/env bash

# Simulate
#   ./_setup/bin/uninstall_from_yaml.sh
# Execute
#   CONFIRM=1 ./_setup/bin/uninstall_from_yaml.sh

set -Eeuo pipefail

APPS_FILE="${1:-_setup/apps.yaml}"
PM="${PM:-brew}"
CONFIRM="${CONFIRM:-0}" # 1 = ejecuta; 0 = dry-run

# Requisitos
command -v yq > /dev/null 2>&1 || {
  echo "❌ yq v4 requerido"
  exit 1
}
command -v brew > /dev/null 2>&1 || {
  echo "❌ Homebrew requerido (PM=brew)"
  exit 1
}
[ -f "$APPS_FILE" ] || {
  echo "❌ No existe $APPS_FILE"
  exit 1
}

# Helpers brew (compatibles bash 3.2)
is_formula_installed() { brew list --formula --versions -- "$1" > /dev/null 2>&1; }
is_cask_installed() { brew list --cask --versions -- "$1" > /dev/null 2>&1; }
uninstall_formula() { brew uninstall --ignore-dependencies --force -- "$1"; }
uninstall_cask() { brew uninstall --cask --force -- "$1"; }

echo "=== Desinstalación (Homebrew) desde $APPS_FILE ==="

# Leemos tokens del YAML, filtramos por PM y deduplicamos con awk
# NOTA: sin pipeline al while (evita subshell); dedupe se hace dentro del < <( )
while IFS= read -r token; do
  [ -z "$token" ] && continue
  short="${token##*/}" # owner/tap/name -> name

  if is_formula_installed "$short"; then
    if [ "$CONFIRM" = "1" ]; then
      echo "⛔ brew uninstall $short"
      uninstall_formula "$short" || true
    else
      echo "DRY-RUN: brew uninstall $short"
    fi
  elif is_cask_installed "$short"; then
    if [ "$CONFIRM" = "1" ]; then
      echo "⛔ brew uninstall --cask $short"
      uninstall_cask "$short" || true
    else
      echo "DRY-RUN: brew uninstall --cask $short"
    fi
  else
    echo "ℹ️  $short no está instalado por brew."
  fi
done < <(
  PM="$PM" yq -r '.apps[] | (.[env(PM)] // .) | select(. != null)' "$APPS_FILE" \
    | awk '!seen[$0]++'
)

# Limpieza opcional de restos/caché
if [ "$CONFIRM" = "1" ]; then
  brew cleanup -s -q || true
fi
