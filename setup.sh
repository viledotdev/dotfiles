#!/bin/bash

if [ "$(basename -- "$SHELL")" != "zsh" ]; then
    echo "This script must be run in a zsh shell."
    exit 1
fi

DOTFILES_DIR="$(realpath "$(dirname "$0")")"
PACKAGE_MANAGER="brew"

if ! command -v "$PACKAGE_MANAGER" &> /dev/null; then
    echo "Installing PM -> $PACKAGE_MANAGER..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "PM -> $PACKAGE_MANAGER already installed."
fi

create_symlink() {
    local target="$(realpath "$1")"
    local link="$HOME/.config/$(basename "$target")"

    if [ ! -e "$link" ]; then
        ln -s "$target" "$link"
        echo "Symlink created: $link -> $target"
    else
        echo "Symlink already done or config file exists: $link"
    fi
}

install_if_missing() {
    local app="$1"

    if ! command -v "$app" &> /dev/null; then
        echo "Installing $app..."
        $PACKAGE_MANAGER install "$app"
    else
        echo "$app already installed."
    fi
}

link_zshrc() {
    ZSHRC_TARGET="$DOTFILES_DIR/zshrc"
    ZSHRC_LINK="$HOME/.config/.zshrc"
    
    if [ ! -L "$ZSHRC_LINK" ]; then
        ln -s "$ZSHRC_TARGET" "$ZSHRC_LINK"
        echo "Symlink created: $ZSHRC_LINK -> $ZSHRC_TARGET"
    else
        echo "Symlink for zshrc already exists or config file exists: $ZSHRC_LINK"
    fi
}

# Main exec:

link_zshrc

for folder in "$DOTFILES_DIR"/*/; do
    app=$(basename "$folder")

    if [[ "$app" =~ ^_ ]]; then
        echo "Skipping $app"
        continue
    fi

    install_if_missing "$app"
    create_symlink "$folder"
done
