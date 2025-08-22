ensure_command() {
  local name="$1" formula="$2"
  if ! command -v "$name" > /dev/null 2>&1; then
    if [[ $PACKAGE_MANAGER == "brew" ]]; then
      echo "⏬ Installing $formula (needed for $name)…"
      brew install "$formula"
    else
      echo "❌ '$name' is required. Install it first." >&2
      exit 1
    fi
  fi
}

ensure_homebrew() {
  if ![[ $PACKAGE_MANAGER == "brew" ]]; then
    return 0
  fi
  if ! command -v brew > /dev/null 2>&1; then
    echo "⏬ Installing Homebrew…"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # Añade brew al PATH para esta sesión
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
  fi
}

bootstrap_prereqs() {
  # 1) Brew en macOS
  ensure_homebrew

  # 2) Flags de Brew (más rápido/silencioso)
  if command -v brew > /dev/null 2>&1; then
    export HOMEBREW_NO_INSTALL_CLEANUP=1
    export HOMEBREW_NO_ENV_HINTS=1
    export HOMEBREW_NO_AUTO_UPDATE=1
    brew update -q || true
  fi

  # 3) YQ (necesario para leer apps.yaml) y utilidades
  ensure_command yq yq
  ensure_command git git

  # (para asdf plugins; algunos los usan)
  if [[ $PACKAGE_MANAGER == "brew" ]]; then
    brew install gpg gnu-tar openssl readline sqlite3 xz zlib tcl-tk || true
  fi
}
