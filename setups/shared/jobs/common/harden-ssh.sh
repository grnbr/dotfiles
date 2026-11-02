#!/bin/bash
set -e

harden_ssh() {
  local CONF="/etc/ssh/sshd_config.d/20-deny_root.conf"
  readonly CONF

  sudo mkdir -p /etc/ssh/sshd_config.d

  if ! grep -qF "PermitRootLogin no" "$CONF" 2>/dev/null; then
    echo "PermitRootLogin no" | sudo tee "$CONF" >/dev/null
    sudo systemctl restart sshd
    echo "SSH hardened: root login disabled."
  else
    echo "SSH already hardened, skipping."
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  harden_ssh
fi
