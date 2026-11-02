#!/bin/bash
set -e

setup_mpd() {
  local readonly MPD_HOME="$HOME/.config/mpd"

  mkdir -p "$MPD_HOME" "$MPD_HOME/playlists" "$HOME/.local/state/mpd"

  if ! command -v mpd >/dev/null 2>&1; then
    echo "MPD is not installed. Skipping..."
    return 0
  fi

  if systemctl --user list-unit-files | grep -q "^mpd.service"; then
    systemctl --user enable --now mpd
  else
    echo "mpd.service not found (systemd user service missing)"
    return 0
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_mpd
fi
