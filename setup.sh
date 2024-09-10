DOTFILES_DIR="$(realpath "$(dirname "$0")")"

#Check if yay is installed or install it
if ! command -v "yay" &> /dev/null; then
        echo "Installing yay..."
        sudo pacman -S --noconfirm "yay"
    else
        echo "yay already installed."
    fi

create_symlink() {
    local target="$(realpath "$1")"
    local link="$(realpath -m "$2")"

    if [ ! -e "$link" ]; then
        ln -s "$target" "$link"
        echo "Symlink created: $link -> $target"
    else
        echo "Symlink already done or config file exists $link"
    fi
}

install_if_missing() {
    local app="$1"

    # Verify if app is already installed
    if ! command -v "$app" &> /dev/null; then
        echo "Installing $app..."
        yay -S --noconfirm "$app"
    else
        echo "$app already installed."
    fi
}

for folder in "$DOTFILES_DIR"/*/; do
    # Obtener el nombre de la carpeta sin la ruta
    app=$(basename "$folder")

    # Excluir carpetas que comiencen con "_"
    if [[ "$app" =~ ^_ ]]; then
        echo "Skipping $app"
        continue
    fi

    # Instalar la aplicación usando el nombre de la carpeta
    install_if_missing "$app"

    # Crear symlink de la carpeta completa en ~/.config
    create_symlink "$folder" "$HOME/.config/$app"
done


