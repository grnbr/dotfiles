#!/usr/bin/env bash
set -e

if ! command -v docker &>/dev/null; then
  echo "Docker is not installed. Install it with your distro's package manager first."
  exit 1
fi

sudo usermod -aG docker "$USER"
sudo systemctl enable --now docker

echo "Docker is ready. Log out and back in so the docker group applies."
