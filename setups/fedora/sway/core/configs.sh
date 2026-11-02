#!/bin/bash
set -e

configure_sway() {
  local extra_configs=(
    kitty
    sway
    gtk-3.0
    gtk-4.0
    waybar
    environment.d
    dunst
  )

  echo "Apply main configs..."
  apply_configs "${extra_configs[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  configure_sway
fi
