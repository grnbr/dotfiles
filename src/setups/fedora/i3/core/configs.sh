#!/bin/bash
set -e

configure_i3() {
  local extra_configs=(
    kitty
    gtk-3.0
    gtk-4.0
    environment.d
    dunst
    polybar
    i3
  )

  echo "Apply main configs..."
  apply_configs "${extra_configs[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  configure_i3
fi
