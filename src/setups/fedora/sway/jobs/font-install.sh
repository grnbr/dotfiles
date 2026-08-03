#!/bin/bash
set -e

FONT_INSTALL_JOB="$ROOT_DIR_LOCAL/src/setups/shared/jobs/install-jetbrains-nerd.sh"
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
