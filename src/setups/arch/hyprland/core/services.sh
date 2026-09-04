#!/bin/bash
set -e

enable_services() {
  services=(
    NetworkManager
    bluetooth
    sshd
  )

  echo "Enabling services..."
  for service in "${services[@]}"; do
    sudo systemctl enable --now "$service"
  done
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  enable_services
fi
