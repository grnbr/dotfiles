#!/bin/bash
set -e

source "$ROOT_DIR/src/setups/fedora/shared/packages/main.sh"

sway=(
  sway
  swaybg
  swaylock
  swayidle

  kitty

  polkit-kde
  sddm
  sddm-wayland-sway
)

# ── wm / ui ────────────────────────────
ui=(
  waybar
  rofi
  dunst
)

# ── wayland utils ──────────────────────
wayland=(
  grim
  slurp

  xdg-desktop-portal-wlr
  gtk3
  gtk4
  qt5-qtwayland
  qt6-qtwayland
)

packages=(
  "${main_packages[@]}"
  "${sway[@]}"
  "${wayland[@]}"
  "${ui[@]}"
)

sudo dnf install -y "${packages[@]}"
