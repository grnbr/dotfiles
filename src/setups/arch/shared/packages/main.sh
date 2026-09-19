#!/bin/bash
set -e

install_main_packages() {
  echo "==> Installing main packages..."

  local system=(
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    polkit
    tar
    bluez
    bluez-tools
    sing-box
  )

  local theme=(
    gtk3
    gtk4
    adw-gtk-theme
    adwaita-icon-theme
    adwaita-cursors
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
    7zip
    fd
    man
    ripgrep
    jq
    zoxide
    yazi
    htop
    # informant
  )

  local apps=(
    qbittorrent
    mpv
    thunar
    tumbler
    neovim
    ffmpegthumbnailer
    chromium
    qutebrowser
    gimp
    steam
    telegram-desktop
    discord
    bitwarden
    guvcview
  )

  local music=(
    mpd
    mpc
    ncmpcpp
  )

  local dev=(
    git
    python-pip
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
    "${theme[@]}"
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
