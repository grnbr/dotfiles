#!/bin/bash
set -e
shopt -s nullglob

apply_config() {
  local config_name="$1"
  local path="$ROOT_DIR/src/configs/$config_name"
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
