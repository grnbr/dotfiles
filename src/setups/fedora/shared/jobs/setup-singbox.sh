#!/bin/bash
set -e

setup_singbox() {
  echo "Installing singbox"

  sudo dnf config-manager addrepo --from-repofile=https://sing-box.app/sing-box.repo &&
    sudo dnf install sing-box # or sing-box-beta
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_singbox
fi
