#!/usr/bin/env bash
set -Eeuo pipefail

APPS_FILE="${1:-_setup/apps.yaml}"
export PM="${PM:-brew}"

yq -r '.apps[] | (.[env(PM)] // .) | select(. != null)' "$APPS_FILE" \
  | while IFS= read -r pkg; do
    [[ -z $pkg ]] && continue
    token="${pkg##*/}"
    if brew list --formula --versions -- "$token" > /dev/null 2>&1 \
      || brew list --cask --versions -- "$token" > /dev/null 2>&1; then
      printf '✓ %s\n' "$token"
    else
      printf '✗ %s (missing)\n' "$token"
    fi
  done
