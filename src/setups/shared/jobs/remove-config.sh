#!/bin/bash
set -e

if [[ -n "${REMOVE_CONFIG_LOADED:-}" ]]; then
  return 0
fi
readonly REMOVE_CONFIG_LOADED=1

remove_config() {
  local config_name="$1"
  local name="$(basename "$config_name")"
  local target="$HOME/.config/$name"

  if [[ -L "$target" ]]; then
    rm "$target"
  elif [[ -e "$target" ]]; then
    echo "SKIP: $target is not a symlink"
    return
  else
    echo "SKIP: $target not found"
    return
  fi
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  remove_config "$1"
fi
