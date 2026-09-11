#!/bin/bash

bootstrap_mirrors() {
  echo "[bootstrap] Setting up mirrors..."

  if ! command -v reflector &>/dev/null; then
    echo "[bootstrap] Installing reflector..."
    sudo pacman -Sy --noconfirm reflector
  fi

  sudo reflector \
    --country Germany,Finland,Netherlands,Poland,Czechia,Kazakhstan \
    --latest 30 \
    --protocol https \
    --download-timeout 10 \
    --save /etc/pacman.d/mirrorlist
}
