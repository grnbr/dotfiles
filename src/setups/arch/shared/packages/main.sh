#!/bin/bash
set -e

install_main_packages() {
  echo "==> Installing main packages..."

  local system=(
    git
    python-pip
  )

  local cli=(
    tree
    fzf
    zsh
    fastfetch
    yt-dlp
    gdu
    bc
    task
    translate-shell
    dictd

  )

  local apps=(
    qbittorrent
    mpv
    thunar
    tumbler
    ffmpegthumbnailer
    chromium
    qutebrowser
    gimp
    steam
  )

  local music=(
    mpd
    mpc
    ncmpcpp
  )

  local dev=(
    nodejs
    npm
    pnpm
    postgresql
    ffmpeg
    iperf3
    perl-image-exiftool
    rust
    go
  )

  local misc=(
    xdg-user-dirs
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

  sudo pacman -S --needed --noconfirm "${packages[@]}"
}

install_aur_packages

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_main_packages
fi
