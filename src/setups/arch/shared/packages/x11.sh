#!/bin/bash
set -e

x11_packages() {
  local action="$1"

  local system=(
    xorg-server
    xorg-xinit
  )

  local cli=(
    xclip
  )

  local utils=(

  )

  local packages=(
    "${system[@]}"
    "${cli[@]}"
    "${utils[@]}"
  )

  case "$action" in
  install)
    echo "==> Installing Hyprland packages..."
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    ;;

  uninstall)
    echo "==> Uninstalling Hyprland packages..."
    sudo pacman -Rns --noconfirm "${packages[@]}"
    ;;
  *)
    echo "Usage: $FUNCNAME {install|uninstall}"
    return 1
    ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  x11_packages "$1"
fi
