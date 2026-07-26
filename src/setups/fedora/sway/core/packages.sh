#!/bin/bash
set -e

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel 2>/dev/null)" || {
  echo "ERROR: not inside a git repo"
  exit 1
}

source "$ROOT_DIR/src/setups/fedora/shared/packages/main.sh"

sway=(
  sway
  swaybg
  swaylock
  swayidle
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
