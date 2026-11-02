#!/bin/bash
set -e

install_brave() {
  if command -v brave-browser &>/dev/null; then
    echo "brave-browser already installed, skipping"
    return
  fi
  sudo dnf install -y dnf-plugins-core
  sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
  sudo dnf install -y brave-browser
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  install_brave
fi
