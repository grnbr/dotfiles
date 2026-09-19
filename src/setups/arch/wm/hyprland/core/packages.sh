#!/bin/bash
set -e

hyprland_packages() {
  local action="$1"

  local system=(
    hyprland
    hyprpaper
    hyprlock
    hypridle
    hyprpolkitagent
    xdg-desktop-portal-hyprland

    qt5-wayland
    qt6-wayland
  )

  local packages=(
    "${system[@]}"
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
  hyprland_packages "$1"
fi
