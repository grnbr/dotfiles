#!/usr/bin/env bash
set -e

setup_grub() {
  sudo pacman -S --needed --noconfirm os-prober fuse3

  sudo sed -i \
    's/^#\?GRUB_DISABLE_OS_PROBER=.*/GRUB_DISABLE_OS_PROBER=false/' \
    /etc/default/grub

  sudo os-prober
  sudo grub-mkconfig -o /boot/grub/grub.cfg
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  setup_grub
fi
