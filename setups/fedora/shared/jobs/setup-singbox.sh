#!/bin/bash
set -e

setup_singbox() {
  echo "Installing singbox"

  if command -v sing-box &>/dev/null; then
    echo "sing-box already installed, skipping"
  else
    echo "Installing sing-box..."

    LATEST_TAG="$(curl -fsSL -o /dev/null -w '%{url_effective}' \
      https://github.com/SagerNet/sing-box/releases/latest | grep -oP 'tag/\K.*')"
    VERSION="${LATEST_TAG#v}"

    TMP_RPM="$(mktemp --suffix=.rpm)"
    curl -fL -o "$TMP_RPM" \
      "https://github.com/SagerNet/sing-box/releases/download/${LATEST_TAG}/sing-box_${VERSION}_linux_x86_64.rpm"

    sudo dnf install -y "$TMP_RPM"
    rm -f "$TMP_RPM"
  fi

  sudo dnf config-manager addrepo --from-repofile=https://sing-box.app/sing-box.repo
  sudo systemctl enable --now sing-box
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_singbox
fi
