#!/bin/bash
set -e

configure_sway() {
  local SHARED_JOBS_DIR="$ROOT_DIR/src/setups/shared/jobs"
  local extra_configs=(
    kitty
    sway
  )

  echo "Apply main configs..."
  source "$SHARED_JOBS_DIR/apply-configs.sh"
  apply_configs "${extra_configs[@]}"
}
