#!/bin/bash
set -e

BUILD_DIR="$HOME/.local/src/yay"

if ! command -v yay &>/dev/null; then
  echo "Installing yay..."

  mkdir -p "$HOME/.local/src"
  git clone https://aur.archlinux.org/yay.git "$BUILD_DIR"

  cd "$BUILD_DIR"
  makepkg -si --noconfirm
fi

aur_packages=(
  brave-bin
  sing-box
)

echo "Installing AUR packages..."

yay -S --noconfirm --needed "${aur_packages[@]}"
