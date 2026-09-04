#!/bin/bash
set -e

install_hyprland_packages() {
  echo "==> Installing Hyprland packages..."

  local system=(
    hyprland
    hyprpaper
    hyprlock
    hypridle
    hyprpolkitagent
    xdg-desktop-portal
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    gtk3
    gtk4
    qt5-wayland
    qt6-wayland
    adwaita-icon-theme
    adwaita-cursors
    sddm
    polkit
  )

  local apps=(
    firefox
    nautilus
    evince
    gnome-calculator
    gnome-sound-recorder
    rhythmbox
    loupe
    libreoffice
    flatpak
    blueman
    network-manager-applet
  )

  local cli=(
    wl-clipboard
  )

  local utils=(
    dunst
    waybar
    rofi
    grim
    slurp
  )

  local audio=(
    pavucontrol
    playerctl
  )

  local packages=(
    "${system[@]}"
    "${apps[@]}"
    "${cli[@]}"
    "${utils[@]}"
    "${audio[@]}"
  )

  sudo pacman -S --needed --noconfirm "${packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_hyprland_packages
fi
