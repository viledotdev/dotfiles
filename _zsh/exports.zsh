# ~/.config/zsh/exports.zsh

export EDITOR='nvim'

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -f /opt/homebrew/opt/asdf/libexec/asdf.sh ]]; then
  . /opt/homebrew/opt/asdf/libexec/asdf.sh
fi

typeset -U path
path_prepend() {
  local i
  for (( i=$#; i>=1; i-- )); do
    [[ -d "${@:$i:1}" ]] && path=("${@:$i:1}" $path)
  done
}

ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"
path_prepend "$ASDF_DIR/shims" "$ASDF_DIR/bin"

export GOPATH="${GOPATH:-$HOME/go}"
path_prepend "$HOME/.local/bin" "$HOME/.dotnet/tools" "$GOPATH/bin" "$HOME/.bin"

if command -v asdf >/dev/null 2>&1; then
  asdf_java_dir="$(asdf where java 2>/dev/null || true)"
  [[ -n "$asdf_java_dir" ]] && export JAVA_HOME="$asdf_java_dir"
fi

_zsh_path_sanitized=()
for d in $path; do
  case "$d" in
    "$JAVA_HOME"/bin) continue ;;
    /opt/homebrew/opt/openjdk/bin) continue ;;
    /Library/Java/JavaVirtualMachines/*/Contents/Home/bin) continue ;;
    $HOME/.asdf/installs/java/*/bin) continue ;;
  esac
  _zsh_path_sanitized+=("$d")
done
path=($_zsh_path_sanitized)

if [[ -d "$ASDF_DIR/shims" ]]; then
  path=("$ASDF_DIR/shims" ${path:#$ASDF_DIR/shims})
fi
if [[ -d "$ASDF_DIR/bin" ]]; then
  path=("$ASDF_DIR/bin" ${path:#$ASDF_DIR/bin})
fi
unset _zsh_path_sanitized

# --- DEBUG 
[[ -n "$ZSH_DEBUG_PATH" ]] && { print -l $path | nl -ba; which -a java; }

# --- PNPM standalone (solo si NO usas Corepack)
# export PNPM_HOME="$HOME/Library/pnpm"
# path_prepend "$PNPM_HOME"

# PNPM (NO Corepack)
# export PNPM_HOME="$HOME/Library/pnpm"; path_prepend "$PNPM_HOME"
# Go tools (go install ...@latest)
# export GOPATH="${GOPATH:-$HOME/go}"
# .NET by cask
#[[ -x /usr/local/share/dotnet/dotnet ]] && path_prepend "/usr/local/share/dotnet" "/usr/local/bin"
