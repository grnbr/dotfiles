# ── system ─────────────────────────────
system=(
  git
)

# ── shell / cli ────────────────────────
cli=(
  neovim
  htop
  tree
  fzf
  zsh
  fastfetch
  nmap-ncat
  yt-dlp
)

# ── apps ───────────────────────────────
apps=(
  firefox
  qbittorrent
  libreoffice
  mpv
  calibre
  loupe
  rhythmbox
  thunar
)

music=(
  mpd
  mpc
  ncmpcpp
)

# ── dev ────────────────────────────────
dev=(
  nodejs
  npm
  postgresql
  ffmpeg
  iperf3
  perl-Image-ExifTool
  rust
)

# ── misc ───────────────────────────────
misc=(
  # xdg-user-dirs
  darkman
  inotify-tools
)

# ── merge all arrays ───────────────────
main_packages=(
  "${system[@]}"
  "${cli[@]}"
  "${audio[@]}"
  "${music[@]}"
  "${apps[@]}"
  "${dev[@]}"
  "${misc[@]}"
)
