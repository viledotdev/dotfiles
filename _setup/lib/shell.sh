# Se source-a desde setup.sh
set -Eeuo pipefail

ensure_zsh_shell() {
  # Evita re-ejecución en bucle
  if [[ ${SETUP_REEXEC_ZSH:-0} == "1" ]]; then
    return 0
  fi

  if [ "$(basename -- "${SHELL:-}")" != "zsh" ]; then
    echo "⚠️ Not running in zsh. Switching..."

    install_if_missing zsh

    if ! grep -q "$(command -v zsh)" /etc/shells 2> /dev/null; then
      echo "Adding $(command -v zsh) to /etc/shells"
      echo "$(command -v zsh)" | sudo tee -a /etc/shells > /dev/null
    fi

    if command -v chsh &> /dev/null; then
      echo "Changing default shell to zsh..."
      chsh -s "$(command -v zsh)" || true
    fi

    echo "Re-running script with zsh..."
    export SETUP_REEXEC_ZSH=1
    exec zsh "$0" "$@"
    exit 0
  fi
}
