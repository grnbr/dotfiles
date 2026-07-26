#!/bin/bash
set -e

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel 2>/dev/null)" || {
  echo "ERROR: not inside a git repo"
  exit 1
}
SHARED_DIR="$ROOT_DIR/src/setups/shared"
SHARED_JOBS_DIR="$SHARED_DIR/jobs"

source "$SHARED_DIR/utils/keep-sudo.sh"
source "$SHARED_DIR/utils/warn.sh"
source "$SHARED_DIR/utils/output-result.sh"
keep_sudo
output_result

echo "Updating system..."

sudo dnf upgrade -y

CORE_SCRIPTS=(
  "$CURRENT_DIR/core/packages.sh"
)

for script in "${CORE_SCRIPTS[@]}"; do
  echo "Running $script"
  source "$script"
done
