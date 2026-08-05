#!/bin/bash
set -e

install_i3_packages() {
  local i3=(
    i3
    feh
    i3lock
    xss-lock
    xautolock
    gvfs
    fd
    fd-find
    tar
    polkit
    xfce-polkit
    sddm
    xdg-desktop-portal-gtk
    xdg-desktop-portal
    gtk3
    gtk4
    adwaita-icon-theme
    adwaita-cursor-theme
    xclip
    xorg-x11-server-Xorg
    xorg-x11-drv-nvidia
  )
  local apps=(
    firefox
    nautilus
    calibre
    loupe
    rhythmbox
    libreoffice
    flatpak
    evince
    chromium
    gnome-calculator
    gnome-sound-recorder
  )
  local cli=(
    nmap-ncat
    htop
  )
  local terminal=(
    kitty
  )
  local utils=(
    dunst
    maim
    slop
    polybar
    rofi
  )
  local packages=(
    "${i3[@]}"
    "${apps[@]}"
    "${cli[@]}"
    "${terminal[@]}"
    "${utils[@]}"
  )
  sudo dnf install -y "${packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_i3_packages
fi
