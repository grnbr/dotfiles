#!/bin/bash
set -e

user_services=(
  pipewire
  pipewire-pulse
  wireplumber
  darkman
  xdg-desktop-portal
  cleanup-old-files.timer
)

echo "Enabling user services..."
for service in "${user_services[@]}"; do
  systemctl --user enable --now "$service"
done
