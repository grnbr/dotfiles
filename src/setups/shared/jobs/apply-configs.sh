#!/bin/bash
set -e

_link_main() {
  local main="$1" dest="$2"
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

_link_systemd() {
  local systemd="$1"
  for f in "$systemd"/*.{service,timer}; do
    echo "$f"
    name="$(basename "$f")"
    ln -sf "$f" "$HOME/.config/systemd/user/$name"
    echo "Linked systemd: $name"
  done
  systemctl --user daemon-reload
}

apply_configs() {
  local ROOT_DIR MAIN OPTIONAL SYSTEMD DEST
  ROOT_DIR="$(git -C "$(dirname "${BASH_SOURCE[0]}")" rev-parse --show-toplevel)"
  MAIN="$ROOT_DIR/src/configs/main"
  OPTIONAL="$ROOT_DIR/src/configs/optional"
  SYSTEMD="$ROOT_DIR/src/configs/systemd/user"
  DEST="$HOME/.config"

  mkdir -p "$DEST"
  cp -a ~/.config "$HOME/.config.bak.$(date +%s)" 2>/dev/null || true

  _link_main "$MAIN" "$DEST"
  _link_optional "$OPTIONAL" "$DEST" "$@"
  _link_systemd "$SYSTEMD"
}
