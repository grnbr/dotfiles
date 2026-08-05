#!/usr/bin/env bash

install_browser_incognito_entries() {
  local apps_dir="$HOME/.local/share/applications"
  mkdir -p "$apps_dir"

  local -A entries=(
    ["brave-incognito.desktop"]="brin|brave-browser --incognito|brave-browser"
    ["firefox-private.desktop"]="frin|firefox --private-window|firefox"
    ["chromium-incognito.desktop"]="cin|chromium-browser --incognito|chromium"
  )

  local file name exec_cmd icon
  for file in "${!entries[@]}"; do
    IFS='|' read -r name exec_cmd icon <<<"${entries[$file]}"

    if [ -f "$apps_dir/$file" ]; then
      warn "desktop entry $file already exists, skipping"
      continue
    fi

    cat >"$apps_dir/$file" <<EOF
[Desktop Entry]
Type=Application
Name=$name
Exec=$exec_cmd
Icon=$icon
Terminal=false
Categories=Network;WebBrowser;
EOF
  done
}

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  install_browser_incognito_entries
fi
