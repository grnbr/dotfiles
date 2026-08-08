#!/bin/bash
set -e

configure_bspwm() {
  local extra_configs=(
    kitty
    gtk-3.0
    gtk-4.0
    environment.d
    dunst
    polybar
    bspwm
    sxhkd
  )

  echo "Apply main configs..."
  apply_configs "${extra_configs[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  configure_bspwm
fi
