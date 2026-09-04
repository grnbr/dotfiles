#!/bin/bash
set -e

install_main_packages() {
  echo "==> Installing main packages..."

  local system=(
    git
    python-pip

    tar
    bluez
    bluez-tools
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
    less
    openbsd-netcat
    rsync
    informant
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

  local terminal=(
    kitty
  )

  local misc=(
    xdg-user-dirs
    darkman
    inotify-tools
  )

  local fonts=(
    inter-font
    noto-fonts
    noto-fonts-emoji
    ttf-jetbrains-mono-nerd
  )

  local packages=(
    "${system[@]}"
    "${cli[@]}"
    "${music[@]}"
    "${apps[@]}"
    "${dev[@]}"
    "${terminal[@]}"
    "${misc[@]}"
    "${fonts[@]}"
  )

  sudo pacman -S --needed --noconfirm "${packages[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_main_packages
fi
