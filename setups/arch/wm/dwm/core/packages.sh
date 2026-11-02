#!/bin/bash
set -e

dwm_packages() {
  local action="$1"

  local system=(
    dwm
    picom
  )

  local utils=(
    feh
  )

  local packages=(
    "${system[@]}"
    "${utils[@]}"
  )

  case "$action" in
  install)
    echo "==> Installing dwm packages..."
    sudo pacman -S --needed --noconfirm "${packages[@]}"
    ;;

  uninstall)
    echo "==> Uninstalling dwm packages..."
    sudo pacman -Rns --noconfirm "${packages[@]}"
    ;;
  *)
    echo "Usage: $FUNCNAME {install|uninstall}"
    return 1
    ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  dwm_packages "$1"
fi
