#!/bin/bash
set -e

configure_hyprland() {
  local extra_configs=(
    hyprland
    kitty
    gtk-3.0
    gtk-4.0
    environment.d
    dunst
    waybar
    xdg-desktop-portal
    rofi
  )

  echo "Apply main configs..."
  apply_configs "${extra_configs[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  configure_hyprland
fi
