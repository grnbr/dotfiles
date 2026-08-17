#!/bin/bash
set -e

if [[ -n "${APPLY_SYSTEMD_LOADED:-}" ]]; then
  return 0
fi
readonly APPLY_SYSTEMD_LOADED=1

_link_systemd() {
  local systemd="$1" dest="$2"
  local name

  mkdir -p "$dest"

  shopt -s nullglob

  for f in "$systemd"/*.{service,timer,target}; do
    name="$(basename "$f")"
    ln -sf "$f" "$dest/$name"
    echo "Linked systemd: $name"
  done

  shopt -u nullglob
}

_link_systemd_unit() {
  local unit="$1" dest="$2"
  local name

  name="$(basename "$unit")"
  mkdir -p "$dest"
  ln -sf "$unit" "$dest/$name"
  echo "Linked systemd: $name"
}

apply_systemd() {
  local manager="${1:-user}"
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"
  local systemd_dir
  local optional_dir
  local dest
  local optional

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR
    CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  case "$manager" in
  user)
    systemd_dir="$ROOT_DIR_LOCAL/src/configs/systemd/main/user"
    optional_dir="$ROOT_DIR_LOCAL/src/configs/systemd/optional/user"
    dest="$HOME/.config/systemd/user"
    ;;

  system)
    systemd_dir="$ROOT_DIR_LOCAL/src/configs/systemd/main/system"
    optional_dir="$ROOT_DIR_LOCAL/src/configs/systemd/optional/system"
    dest="/etc/systemd/system"
    ;;

  *)
    echo "ERROR: invalid systemd manager: $manager" >&2
    return 1
    ;;
  esac

  # Main units
  _link_systemd "$systemd_dir" "$dest"

  # Optional units
  shift

  for optional in "$@"; do
    optional_path="$optional_dir/$optional"

    if [[ -d "$optional_path" ]]; then
      _link_systemd "$optional_path" "$dest"

    elif [[ -f "$optional_path" ]]; then
      _link_systemd_unit "$optional_path" "$dest"

    else
      echo "WARNING: optional systemd unit/module not found: $optional_path" >&2
    fi
  done

  if [[ "$manager" == "user" ]]; then
    systemctl --user daemon-reload
  else
    sudo systemctl daemon-reload
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  apply_systemd "$@"
fi
