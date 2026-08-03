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

echo "Installing informant..."

yay -S --noconfirm --needed informant

sudo usermod -aG informant "$USER"
