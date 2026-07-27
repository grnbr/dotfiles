#!/bin/bash
set -e

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly CURRENT_DIR

ROOT_DIR="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel 2>/dev/null)" || {
  echo "ERROR: not inside a git repo"
  exit 1
}
export ROOT_DIR
readonly ROOT_DIR

SHARED_DIR="$ROOT_DIR/src/setups/shared"

source "$SHARED_DIR/utils/keep-sudo.sh"
source "$SHARED_DIR/utils/warn.sh"
source "$SHARED_DIR/utils/output-result.sh"
keep_sudo
output_result

echo "Updating system..."

sudo dnf upgrade -y

source "$CURRENT_DIR/core/packages.sh" install_sway_packages

source "$CURRENT_DIR/core/configs.sh"
configure_sway

source "$CURRENT_DIR/core/services.sh"
enable_services

source "$CURRENT_DIR/core/user-services.sh"
enable_user_services

JOBS_DIR="$CURRENT_DIR/jobs"
for job in "$JOBS_DIR"/*.sh; do
  [ -e "$job" ] || continue
  echo "→ Running job $job"
  bash "$job"
done

echo "All done! Reboot recommended."

if [ -s $WARNINGS_LOG_PATH ]; then
  echo ""
  echo "=== Warnings ==="
  cat "$WARNINGS_LOG_PATH"
  rm "$WARNINGS_LOG_PATH"
fi
