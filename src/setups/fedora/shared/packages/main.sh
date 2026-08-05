#!/bin/bash
set -e

install_main_packages() {
  echo "==> Installing main packages..."

  local system=(
    git
  )

  local cli=(
    neovim
    tree
    fzf
    zsh
    fastfetch
    yt-dlp
    gdu
    translate-shell
    dictd
  )

  local apps=(
    qbittorrent
    mpv
    thunar
  )

  local music=(
    mpd
    mpc
    ncmpcpp
  )

  local dev=(
    nodejs
    npm
    postgresql
    ffmpeg
    iperf3
    perl-Image-ExifTool
    rust
    cargo
  )

  local misc=(
    # xdg-user-dirs
    darkman
    inotify-tools
  )

  local packages=(
    "${system[@]}"
    "${cli[@]}"
    "${music[@]}"
    "${apps[@]}"
    "${dev[@]}"
    "${misc[@]}"
  )

  sudo dnf install -y "${packages[@]}"
}

install_main_packages

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_main_packages
fi
