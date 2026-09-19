#!/bin/bash
set -e

configure_hyprland() {
  local action="$1"

  local shared_jobs_dir="${SHARED_JOBS_DIR:-}"

  if [[ -z "$shared_jobs_dir" ]]; then
    local current_dir
    current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    local root_dir
    root_dir="$(git -C "$current_dir" rev-parse --show-toplevel)" || {
      echo "ERROR: not inside a git repo"
      return 1
    }

    shared_jobs_dir="$root_dir/src/setups/shared/jobs"
  fi

  source "$shared_jobs_dir/apply-config.sh"
  source "$shared_jobs_dir/remove-config.sh"

  local configs=(
    optional/hypr
    optional/waybar
  )

  case "$action" in
  install)
    echo "==> Applying Hyprland configs..."
    for config in "${configs[@]}"; do
      apply_config "$config"
    done
    ;;

  uninstall)
    echo "==> Removing Hyprland configs..."
    for config in "${configs[@]}"; do
      remove_config "$config"
    done
    ;;
  *)
    echo "Usage: $FUNCNAME {install|uninstall}"
    return 1
    ;;
  esac

}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  configure_hyprland "$1"
fi
