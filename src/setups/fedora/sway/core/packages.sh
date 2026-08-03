#!/bin/bash
set -e

install_sway_packages() {
  local sway=(
    sway
    swaybg
    swaylock
    swayidle

    gvfs
    fd
    fd-find
    tar
    polkit
    xfce-polkit

    sddm
    sddm-wayland-sway

    xdg-desktop-portal-wlr
    xdg-desktop-portal
    gtk3
    gtk4
    adwaita-icon-theme
    adwaita-cursor-theme
  )

  local apps=(
    nautilus
  )

  local terminal=(
    kitty
  )

  local utils=(
    dunst
    grim
    slurp
    waybar
    rofi
  )

  local packages=(
    "${sway[@]}"
    "${apps[@]}"
    "${terminal[@]}"
    "${utils[@]}"
  )

  sudo dnf install -y "${packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_sway_packages
fi
