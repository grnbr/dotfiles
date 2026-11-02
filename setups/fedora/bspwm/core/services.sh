#!/bin/bash
set -e

enable_services() {
  services=(

  )

  echo "Enabling services..."
  for service in "${services[@]}"; do
    sudo systemctl enable --now "$service"
  done
}
