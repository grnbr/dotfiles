#!/bin/bash
set -e

install_bspwm_packages() {
  local system=(
    bspwm
    sxhkd
    feh
    i3lock
    xss-lock
    xautolock
    gvfs
    fd
    fd-find
    tar
    bluez
    bluez-tools

    sddm

    polkit
    xfce-polkit

    xdg-desktop-portal-gtk
    xdg-desktop-portal

    gtk3
    gtk4
    adwaita-icon-theme
    adwaita-cursor-theme

    xclip
    xorg-x11-server-Xorg
    xorg-x11-drv-nvidia
    xset
    xrandr
    picom
    xev
    wmctrl
  )
  local apps=(
    nautilus

    firefox
    calibre
    loupe
    rhythmbox
    libreoffice
    flatpak
    evince
    gnome-calculator
    gnome-sound-recorder
    arandr
    blueman
    network-manager-applet
  )
  local cli=(
    nmap-ncat
    htop
    rsync
  )
  local terminal=(
    kitty
  )
  local utils=(
    dunst
    # maim
    # slop
    polybar
    rofi
    flameshot
  )
  local audio=(
    pavucontrol
    pulseaudio-utils
    playerctl
  )
  local fonts=(
    rsms-inter-fonts
    google-noto-color-emoji-fonts
    google-noto-sans-fonts
    google-noto-serif-fonts
  )
  local packages=(
    "${system[@]}"
    "${apps[@]}"
    "${cli[@]}"
    "${terminal[@]}"
    "${utils[@]}"
    "${audio[@]}"
    "${fonts[@]}"
  )
  sudo dnf install -y "${packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_bspwm_packages
fi
