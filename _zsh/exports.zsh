# --- editor
export EDITOR='nvim'

# --- Homebrew delante del PATH
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Go
export GOPATH="$HOME/go"

# --- Java (OpenJDK vía brew)
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
# Usa el JDK activo si existe; si no, cae al de brew
if JAVA_HOME_CALC="$(/usr/libexec/java_home 2>/dev/null)"; then
  export JAVA_HOME="$JAVA_HOME_CALC"
else
  export JAVA_HOME="/opt/homebrew/opt/openjdk"
fi

# --- pnpm (shims/instalaciones globales)
export PNPM_HOME="$HOME/Library/pnpm"

# --- dotnet (según cómo lo instalaste)
if [[ -d /opt/homebrew/opt/dotnet/libexec ]]; then
  export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec"
elif [[ -d /usr/local/share/dotnet ]]; then
  export DOTNET_ROOT="/usr/local/share/dotnet"
fi

# --- helpers PATH (zsh)
typeset -U path                # de-dup de entradas en $path
path_add() {                   # añade solo si existe el dir
  for p in "$@"; do
    [[ -d $p ]] && path=("$p" $path)
  done
}

# añade rutas útiles (orden: más prioritarias primero)
path_add \
  "$HOME/.bin" \
  "$GOPATH/bin" \
  "$PNPM_HOME" \
  "$JAVA_HOME/bin" \
  "$DOTNET_ROOT"

# (brew shellenv ya añadió /opt/homebrew/bin y /opt/homebrew/sbin)
