#!/bin/bash
set -e

install_aur_packages() {
  local BUILD_DIR="$HOME/.local/src/yay"

  if ! command -v yay &>/dev/null; then
    echo "Installing yay..."
    sudo pacman -S --needed git base-devel
    rm -rf "$BUILD_DIR"
    mkdir -p "$HOME/.local/src"
    git clone https://aur.archlinux.org/yay.git "$BUILD_DIR"
    (
      cd "$BUILD_DIR"
      makepkg -si --noconfirm
    )
  fi

  local aur_packages=(
    brave-bin
  )

  echo "Installing AUR packages..."
  yay -S --noconfirm --needed "${aur_packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_aur_packages
fi
