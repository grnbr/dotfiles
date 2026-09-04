#!/bin/bash
set -e

enable_user_services() {
  local extra_systemd=(
  )

  apply_systemd user "${extra_systemd[@]}"

  user_services=(
    pipewire
    pipewire-pulse
    wireplumber
    darkman
    xdg-desktop-portal
    cleanup-old-files.timer
    mpd
  )

  echo "Enabling user services..."
  for service in "${user_services[@]}"; do
    if systemctl --user list-unit-files | grep -q "^${service}"; then
      if ! systemctl --user is-enabled --quiet "$service" 2>/dev/null; then
        if systemctl --user enable --now "$service"; then
          echo "Enabled: $service"
        else
          echo "WARNING: $service failed to start (enabled but not running) — check config"
        fi
      else
        echo "$service already enabled, skipping."
      fi
    else
      echo "WARNING: $service unit not found, skipping."
    fi
  done
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  enable_user_services
fi
