#!/usr/bin/env bash
setup_darkman() {
  local script_dir="$HOME/.local/share/darkman"
  local script_path="$script_dir/handler.sh"
  local source_handler="$(dirname "${BASH_SOURCE[0]}")/darkman/handler.sh"
  local wallpaper_dir="$HOME/Pictures/Wallpapers"
  local config_dir="$HOME/.config/darkman"
  local config_path="$config_dir/config.yaml"

  mkdir -p "$script_dir" "$wallpaper_dir" "$config_dir"

  cp "$source_handler" "$script_path"
  chmod +x "$script_path"

  if [[ ! -f "$config_path" ]]; then
    cat >"$config_path" <<'EOF'
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
