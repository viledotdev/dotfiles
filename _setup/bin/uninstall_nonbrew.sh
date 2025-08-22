#!/usr/bin/env bash
set -Eeuo pipefail

# Simulate
#    ./_setup/bin/uninstall_nonbrew.sh
# Execute
#    CONFIRM=1 ./_setup/bin/uninstall_nonbrew.sh --all-jdks

CONFIRM="${CONFIRM:-0}" # 1 = ejecutar; 0 = dry-run
ALL_JDKS=0
[[ ${1:-} == "--all-jdks" ]] && ALL_JDKS=1

run() {
  if [[ $CONFIRM == "1" ]]; then
    echo "⛔ $*"
    eval "$*"
  else
    echo "DRY-RUN: $*"
  fi
}

echo "=== Node (instalador .pkg / manual) ==="
run "sudo rm -f /usr/local/bin/{node,npm,npx}"
run "sudo rm -rf /usr/local/lib/node_modules /usr/local/include/node"
run "sudo rm -rf /usr/local/share/doc/node /usr/local/share/man/man1/node*"

echo "=== pnpm global (npm standalone) ==="
run "npm -g rm pnpm || true"
run 'rm -rf "$HOME/Library/pnpm"'

echo "=== Go (tarball .pkg en /usr/local/go) ==="
run "sudo rm -rf /usr/local/go"

echo "=== .NET SDK (instalador oficial) ==="
run "sudo rm -rf /usr/local/share/dotnet"
run "sudo rm -f /usr/local/bin/dotnet"
run "sudo rm -f /etc/paths.d/dotnet /etc/paths.d/dotnet-cli-tools || true"

echo "=== JDKs instalados por .pkg (/Library/Java/JavaVirtualMachines) ==="
if [[ $ALL_JDKS == "1" ]]; then
  for d in /Library/Java/JavaVirtualMachines/*.jdk; do
    [[ -e $d ]] || continue
    run "sudo rm -rf \"$d\""
  done
else
  echo "ℹ️  Pasa --all-jdks para borrarlos todos. Actualmente tienes:"
  ls -1 /Library/Java/JavaVirtualMachines/*.jdk 2> /dev/null || echo "(ninguno)"
fi

echo "=== Docker Desktop no-brew ==="
run "osascript -e 'quit app \"Docker\"' || true"
run "sudo rm -rf /Applications/Docker.app"
run 'rm -rf "$HOME/.docker" "$HOME/Library/Containers/com.docker.docker" "$HOME/Library/Group Containers/group.com.docker"'

echo "=== Fuentes manuales (Nerd Fonts en ~/Library/Fonts) ==="
run 'rm -f "$HOME/Library/Fonts"/*Nerd* 2>/dev/null || true'
