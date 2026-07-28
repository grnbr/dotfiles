# ── system ─────────────────────────────
system=(
  git
  polkit
  gvfs
  fd
  fd-find
  tar
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
)

music=(
  mpd
  mpc
  ncmpcpp
)

# ── file management ────────────────────
files=(
  nautilus
  thunar
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
  xdg-user-dirs
  xdg-desktop-portal
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
  "${files[@]}"
  "${dev[@]}"
  "${misc[@]}"
)
