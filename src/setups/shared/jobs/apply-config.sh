#!/bin/bash
set -e

if [[ -n "${APPLY_CONFIG_LOADED:-}" ]]; then
  return 0
fi
readonly APPLY_CONFIG_LOADED=1

apply_config() {
  local config_name="$1"
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  local path="$ROOT_DIR_LOCAL/src/configs/$config_name"
  local name="$(basename "$path")"
  local dest="$HOME/.config"
  local target="$dest/$name"

  [ -e "$path" ] || {
    echo "SKIP: $name not found"
    return
  }

  mkdir -p "$dest" "$dest.bak"

  cp -a "$dest/$name" "$dest.bak/$name.$(date +%s)" 2>/dev/null || true

  { [ -e "$target" ] || [ -L "$target" ]; } && rm -rf -- "$target"
  ln -s "$path" "$target"
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  apply_config "$@"
fi
