# Dotfiles Setup (zsh + yq)

## Requisitos

- **zsh** as shell
- **sudo** available (Linux)
- **yq** installed for YAML on CLI

### Install yq

```
#MacOS
brew install yq
#Ubuntu/Debian
sudo apt update && sudo apt install -y yq
#Arch
sudo pacman -Sy --noconfirm yq
```

### Install config

```
./setup.sh
```
