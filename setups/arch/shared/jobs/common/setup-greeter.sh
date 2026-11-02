#!/usr/bin/env bash
set -e

setup_greeter() {
  local session_command="start-hyprland"
  local config="/etc/greetd/config.toml"
  local packages=(greetd greetd-tuigreet)

  sudo pacman -S --noconfirm --needed "${packages[@]}"

  sudo sed -i \
    "s|^[[:space:]]*command[[:space:]]*=.*|command = \"tuigreet --time --remember --cmd $session_command\"|" \
    "$config"

  sudo systemctl enable greetd
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  setup_greeter
fi
