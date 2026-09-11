#!/usr/bin/env bash

set_wallpaper() {
  local wallpaper="$1"

  if [[ -z "$wallpaper" ]]; then
    echo "set_wallpaper: no path provided" >&2
    return 1
  fi

  if [[ ! -f "$wallpaper" ]]; then
    echo "set_wallpaper: file not found: $wallpaper" >&2
    return 1
  fi

  if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    if pgrep -x hyprpaper >/dev/null 2>&1; then
      hyprctl hyprpaper wallpaper ",$wallpaper"
    fi
  elif [[ -n "${DISPLAY:-}" ]]; then
    feh --bg-fill "$wallpaper"
  fi
}

main() {
  local wallpaper_dir="$HOME/Pictures/Wallpapers"
  mkdir -p "$wallpaper_dir"

  case "$1" in
  dark)
    if [[ -d /usr/share/themes/adw-gtk3-dark ]]; then
      gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
    fi
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    set_wallpaper "$wallpaper_dir/dark.jpg"
    ;;
  light)
    if [[ -d /usr/share/themes/adw-gtk3 ]]; then
      gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3"
    fi
    gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
    set_wallpaper "$wallpaper_dir/light.jpg"
    ;;
  esac
}
main "$@"
