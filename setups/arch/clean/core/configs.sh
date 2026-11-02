#!/bin/bash
set -e

configure() {
  local shared_jobs_dir="${SHARED_JOBS_DIR:-}"

  if [[ -z "$shared_jobs_dir" ]]; then
    local current_dir
    current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

    local root_dir
    root_dir="$(git -C "$current_dir" rev-parse --show-toplevel)" || {
      echo "ERROR: not inside a git repo"
      return 1
    }

    shared_jobs_dir="$root_dir/setups/shared/jobs"
  fi

  source "$shared_jobs_dir/apply-configs.sh"

  local extra_configs=(
    kitty
    gtk-3.0
    gtk-4.0
    environment.d
    dunst
    xdg-desktop-portal
    rofi
    zathura
  )

  echo "Apply main configs..."
  apply_configs "${extra_configs[@]}"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  configure
fi
