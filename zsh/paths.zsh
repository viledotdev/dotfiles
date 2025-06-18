export PATH="$HOME/.bin:$PATH"

# Homebrew
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# Go
export PATH="/usr/local/go/bin:$PATH"

# Java
export PATH="$JAVA_HOME/bin:$PATH"

# pnpm (solo si no está ya)
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
