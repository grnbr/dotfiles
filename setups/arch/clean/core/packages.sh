#!/bin/bash
set -e

install_packages() {
  echo "==> Installing Hyprland packages..."

  local system=(

  )

  local apps=(
    firefox
    gnome-calculator
    gnome-sound-recorder
    rhythmbox
    loupe
    libreoffice
    flatpak
    blueman
    network-manager-applet
  )

  local utils=(
    dunst
    rofi
  )

  local audio=(
    pavucontrol
    playerctl
  )

  local packages=(
    "${system[@]}"
    "${apps[@]}"
    "${utils[@]}"
    "${audio[@]}"
  )

  sudo pacman -S --needed --noconfirm "${packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_packages
fi
