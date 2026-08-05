#!/bin/bash
set -e
# ~/dotfiles/src/setups/shared/jobs/common/install-waybar-pomodoro.sh

log_err() {
  if command -v warn &>/dev/null; then
    warn "$@"
  else
    echo "[warn] $*" >&2
  fi
}

install_waybar_pomodoro() {
  local binary_name="waybar-module-pomodoro"
  local install_dir="$HOME/.local/bin"
  local repo_url="https://github.com/Andeskjerf/waybar-module-pomodoro.git"
  local build_dir
  build_dir="$(mktemp -d)"

  if ! command -v cargo &>/dev/null; then
    log_err "cargo not found, skipping $binary_name install (install rustup first)"
    return
  fi

  if [ -x "$install_dir/$binary_name" ] && [ "${1:-}" != "--force" ]; then
    log_err "$binary_name already installed at $install_dir, skipping (pass --force to rebuild)"
    return
  fi

  mkdir -p "$install_dir"

  if ! git clone --depth 1 "$repo_url" "$build_dir"; then
    log_err "git clone failed for $binary_name"
    rm -rf "$build_dir"
    return
  fi

  if ! (cd "$build_dir" && cargo build --release); then
    log_err "cargo build failed for $binary_name"
    rm -rf "$build_dir"
    return
  fi

  cp "$build_dir/target/release/$binary_name" "$install_dir/$binary_name"
  chmod +x "$install_dir/$binary_name"
  rm -rf "$build_dir"
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  install_waybar_pomodoro "$@"
fi
