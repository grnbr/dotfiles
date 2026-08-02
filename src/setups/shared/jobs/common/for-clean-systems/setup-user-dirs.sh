#!/bin/bash
set -e

setup_user_dirs() {
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

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
  rmdir --ignore-fail-on-non-empty ~/Desktop ~/Documents ~/Downloads ~/Music ~/Pictures ~/Templates ~/Videos ~/Public 2>/dev/null || true
  echo "[dirs] done"
}
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_user_dirs
fi
