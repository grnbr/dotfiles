#!/bin/bash
set -e

if [[ -n "${APPLY_CONFIGS_LOADED:-}" ]]; then
  return 0
fi
readonly APPLY_CONFIGS_LOADED=1

_link_main() {
  local main="$1" dest="$2"
  local name target

  for item in "$main"/*; do
    name="$(basename "$item")"
    [[ "$name" == "systemd" ]] && continue
    [ -e "$item" ] || {
      echo "SKIP: $item"
      continue
    }
    target="$dest/$name"
    { [ -e "$target" ] || [ -L "$target" ]; } && rm -rf -- "$target"
    ln -s "$item" "$target"
  done
}

_link_optional() {
  local optional="$1" dest="$2"
  local name target

  shift 2
  for name in "$@"; do
    [ -n "$name" ] || {
      echo "SKIP: empty name"
      continue
    }
    item="$optional/$name"
    [ -e "$item" ] || {
      echo "SKIP: $item not found"
      continue
    }
    target="$dest/$name"
    { [ -e "$target" ] || [ -L "$target" ]; } && rm -rf -- "$target"
    ln -s "$item" "$target"
  done
}

apply_configs() {
  local MAIN OPTIONAL SYSTEMD DEST
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  MAIN="$ROOT_DIR_LOCAL/src/configs/main"
  OPTIONAL="$ROOT_DIR_LOCAL/src/configs/optional"
  DEST="$HOME/.config"

  mkdir -p "$DEST"
  cp -a ~/.config "$HOME/.config.bak.$(date +%s)" 2>/dev/null || true

  _link_main "$MAIN" "$DEST"
  _link_optional "$OPTIONAL" "$DEST" "$@"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  apply_configs "$@"
fi
