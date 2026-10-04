#!/bin/bash
set -e

if [[ -n "${APPLY_LOCAL_BIN_LOADED:-}" ]]; then
  return 0
fi
readonly APPLY_LOCAL_BIN_LOADED=1

_link_bin() {
  local main="$1" dest="$2"
  local item name target

  for item in "$main"/*; do
    [ -f "$item" ] || {
      echo "SKIP: $item"
      continue
    }
    name="$(basename "$item")"
    target="$dest/$name"

    chmod +x "$item"

    if [ -L "$target" ]; then
      rm -- "$target"
    elif [ -e "$target" ]; then
      mv -- "$target" "$target.bak.$(date +%s)"
      echo "BACKUP: $target"
    fi

    ln -s "$item" "$target"
  done
}

apply_local_bin() {
  local MAIN DEST
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  MAIN="$ROOT_DIR_LOCAL/src/bin"
  DEST="$HOME/.local/bin"

  mkdir -p "$DEST"

  _link_bin "$MAIN" "$DEST"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  apply_local_bin "$@"
fi
