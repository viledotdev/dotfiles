# ~/.config/zsh/exports.zsh

# --- editor
export EDITOR='nvim'

# --- Homebrew (añade /opt/homebrew/{bin,sbin} al PATH)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- asdf (shims + funciones)
if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

# --- de-dup del PATH y helper para preprender rutas
typeset -U path
path_prepend() {
  local i
  for (( i=$#; i>=1; i-- )); do
    [[ -d "${@:$i:1}" ]] && path=("${@:$i:1}" $path)
  done
}

# --- asdf primero en PATH (shims y bin)
ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
path_prepend "$ASDF_DIR/shims" "$ASDF_DIR/bin"

# --- rutas útiles de usuario
export GOPATH="${GOPATH:-$HOME/go}"
path_prepend "$HOME/.local/bin" "$HOME/.dotnet/tools" "$GOPATH/bin" "$HOME/.bin"

# --- JAVA_HOME desde asdf (no metas $JAVA_HOME/bin en PATH)
if command -v asdf >/dev/null 2>&1; then
  asdf_java_dir="$(asdf where java 2>/dev/null || true)"
  [[ -n "$asdf_java_dir" ]] && export JAVA_HOME="$asdf_java_dir"
fi

# --- guard final: limpia entradas java que se hayan colado y reafirma shims
for d in "$JAVA_HOME/bin" /opt/homebrew/opt/openjdk/bin; do
  [[ -n "$d" ]] && path=(${path:#$d})
done
if [[ -d "$ASDF_DIR/shims" ]]; then
  path=("$ASDF_DIR/shims" ${path:#$ASDF_DIR/shims})
fi
if [[ -d "$ASDF_DIR/bin" ]]; then
  path=("$ASDF_DIR/bin" ${path:#$ASDF_DIR/bin})
fi

# --- PNPM standalone (solo si NO usas Corepack)
# export PNPM_HOME="$HOME/Library/pnpm"
# path_prepend "$PNPM_HOME"

# PNPM (NO Corepack)
# export PNPM_HOME="$HOME/Library/pnpm"; path_prepend "$PNPM_HOME"
# Go tools (go install ...@latest)
# export GOPATH="${GOPATH:-$HOME/go}"
# .NET by cask
#[[ -x /usr/local/share/dotnet/dotnet ]] && path_prepend "/usr/local/share/dotnet" "/usr/local/bin"
