#!/usr/bin/env bash
set -e

setup_desktop_entries() {
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  source "$ROOT_DIR_LOCAL/src/setups/shared/jobs/setup-desktop-entries.sh"

  local qutebrowser_config="$HOME/.config/qutebrowser/config.py"

  declare -A browser_entries=(
    ["brave-incognito.desktop"]="brin|brave --incognito|brave"
    ["firefox-private.desktop"]="frin|firefox --private-window|firefox"
    ["chromium-incognito.desktop"]="cin|chromium --incognito|chromium"
    ["qutebrowser-private.desktop"]="qin|qutebrowser -T -C $qutebrowser_config|qutebrowser"
  )

  install_desktop_entries browser_entries
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  setup_desktop_entries
fi
