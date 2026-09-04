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
source "$SCRIPT_DIR/bootstrap/mirrors.sh"

keep_sudo
output_result

bootstrap_mirrors

echo "Updating system..."
sudo pacman -Syu --noconfirm

source "$ROOT_DIR/src/setups/arch/shared/packages/main.sh"
install_main_packages

source "$CURRENT_DIR/core/packages.sh"
install_arch_packages

source "$SHARED_JOBS_DIR/apply-configs.sh"
source "$SHARED_JOBS_DIR/apply-systemd.sh"
source "$CURRENT_DIR/core/configs.sh"
configure_arch

source "$CURRENT_DIR/core/services.sh"
enable_services

source "$CURRENT_DIR/core/user-services.sh"
enable_user_services

# --- Run jobs ---
JOBS_DIR="$SCRIPT_DIR/jobs"
for job in "$JOBS_DIR"/*.sh; do
  [ -e "$job" ] || continue
  echo "→ Running job $job"
  bash "$job"
done

# --- Install Zsh at the end ---
#echo "Installing Zsh..."
#bash "$SHARED_JOBS_DIR/install-zsh.sh"

#echo "Install informant..."
#bash "$ROOT_DIR/src/setups/arch/shared/install-informant.sh"

echo "All done! Reboot recommended."

if [ -s $WARNINGS_LOG_PATH ]; then
  echo ""
  echo "=== Warnings ==="
  cat "$WARNINGS_LOG_PATH"
  rm "$WARNINGS_LOG_PATH"
fi
