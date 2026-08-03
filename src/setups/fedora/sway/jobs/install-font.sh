#!/bin/bash
set -e

install_font() {
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  local FONT_INSTALL_JOB="$ROOT_DIR_LOCAL/src/setups/shared/jobs/install-jetbrains-nerd.sh"

  if [ -e "$FONT_INSTALL_JOB" ]; then
    if ! bash "$FONT_INSTALL_JOB"; then
      if command -v warn &>/dev/null; then
        warn "Nerd Font install failed"
      else
        echo "Nerd Font install failed"
      fi
    fi
  else
    if command -v warn &>/dev/null; then
      warn "install-jetbrains-nerd.sh not found, skipping"
    else
      echo "install-jetbrains-nerd.sh not found, skipping"
    fi
  fi
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  install_font
fi
