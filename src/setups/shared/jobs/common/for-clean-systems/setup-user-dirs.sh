#!/bin/bash
set -e

source "$ROOT_DIR/src/setups/shared/jobs/apply-config.sh"

echo "[dirs] setting up user dirs..."

mkdir -p ~/downloads ~/documents ~/pictures ~/music ~/videos ~/tmp
apply_config "optional/user-dirs.dirs"

if ! command -v xdg-user-dirs-update &>/dev/null; then
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
    fedora)
      sudo dnf install -y xdg-user-dirs
      ;;
    *)
      echo "Unsupported distro: $ID"
      exit 1
      ;;
    esac
  fi
fi

xdg-user-dirs-update
rmdir Desktop Documents Downloads Music Pictures Templates Videos Public 2>/dev/null
echo "[dirs] done"
