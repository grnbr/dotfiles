#!/bin/bash
set -e

source "$ROOT_DIR/src/setups/fedora/shared/packages/main.sh"

sway=(
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
)

apps=(
  nautilus
)

terminal=(
  kitty
)

utils=(
  dunst
  grim
  slurp
  waybar
  rofi
)

packages=(
  "${main_packages[@]}"
  "${sway[@]}"
  "${apps[@]}"
  "${terminal[@]}"
  "${utils[@]}"
)

sudo dnf install -y "${packages[@]}"
