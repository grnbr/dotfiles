#!/usr/bin/env bash

setup_darkman() {
  local script_dir="$HOME/.local/share/darkman"
  local script_path="$script_dir/handler.sh"
  local wallpaper_dir="$HOME/Pictures/Wallpapers"
  local config_dir="$HOME/.config/darkman"
  local config_path="$config_dir/config.yaml"

  mkdir -p "$script_dir" "$wallpaper_dir" "$config_dir"

  cat >"$script_path" <<EOF
#!/bin/sh
case "\$1" in
dark)
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  feh --bg-fill "$wallpaper_dir/dark.jpg"
  ;;
light)
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  feh --bg-fill "$wallpaper_dir/light.jpg"
  ;;
esac
EOF
  chmod +x "$script_path"

  if [[ ! -f "$config_path" ]]; then
    cat >"$config_path" <<EOF
lat:
lng:
EOF
  fi

  systemctl --user restart darkman
  systemctl --user restart xdg-desktop-portal

  echo "darkman setup complete."
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_darkman
fi
