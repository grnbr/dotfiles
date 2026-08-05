#!/bin/bash
set -e

readonly CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ROOT_DIR="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel 2>/dev/null)" || {
  echo "ERROR: not inside a git repo"
  exit 1
}
readonly ROOT_DIR
export ROOT_DIR

readonly SHARED_DIR="$ROOT_DIR/src/setups/shared"
export SHARED_DIR

readonly UTILS_DIR="$SHARED_DIR/utils"
export UTILS_DIR

readonly SHARED_JOBS_DIR="$ROOT_DIR/src/setups/shared/jobs"
export SHARED_JOBS_DIR

source "$UTILS_DIR/keep-sudo.sh"
source "$UTILS_DIR/warn.sh"
source "$UTILS_DIR/output-result.sh"
keep_sudo
output_result

sudo dnf config-manager disable fedora-cisco-openh264

echo "Updating system..."

sudo dnf upgrade -y
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

source "$ROOT_DIR/src/setups/fedora/shared/packages/main.sh"
install_main_packages

source "$CURRENT_DIR/core/packages.sh"
install_sway_packages

source "$SHARED_JOBS_DIR/apply-configs.sh"
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

sudo dnf config-manager enable fedora-cisco-openh264

echo "All done! Reboot recommended."

if [ -s $WARNINGS_LOG_PATH ]; then
  echo ""
  echo "=== Warnings ==="
  cat "$WARNINGS_LOG_PATH"
  rm "$WARNINGS_LOG_PATH"
fi
