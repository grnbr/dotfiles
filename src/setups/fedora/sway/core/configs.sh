#!/bin/bash
set -e

configure_sway() {
  local extra_configs=(
    kitty
    sway
  )

  echo "Apply main configs..."
  apply_configs "${extra_configs[@]}"
}

configure_sway
