#!/bin/bash
set -e

source "$ROOT_DIR/src/setups/shared/utils/warn.sh"
source "$ROOT_DIR/src/setups/shared/jobs/apply-config.sh"

echo "[dirs] setting up user dirs..."

mkdir -p ~/downloads ~/documents ~/pictures ~/music ~/videos ~/tmp
apply_config "optional/user-dirs.dirs"

if command -v xdg-user-dirs-update &>/dev/null; then
  xdg-user-dirs-update
else
  warn "xdg-user-dirs-update not found, skipping"
fi
echo "[dirs] done"

rmdir Desktop Documents Downloads Music Pictures Templates Videos Public 2>/dev/null
