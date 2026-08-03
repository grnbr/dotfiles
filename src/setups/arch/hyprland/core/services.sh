#!/bin/bash
set -e

services=(
  NetworkManager
  bluetooth
  sshd
)

echo "Enabling services..."
for service in "${services[@]}"; do
  sudo systemctl enable --now "$service"
done
