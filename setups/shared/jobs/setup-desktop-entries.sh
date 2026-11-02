#!/usr/bin/env bash
# Generic desktop-entry writer. Takes the NAME of an associative array
# (declared by the caller) as its only argument.
# Expected format per entry:
#   ["filename.desktop"]="DisplayName|exec command|icon-name"
install_desktop_entries() {
  local -n entries_ref="$1"
  local apps_dir="$HOME/.local/share/applications"
  mkdir -p "$apps_dir"

  local file name exec_cmd icon
  for file in "${!entries_ref[@]}"; do
    IFS='|' read -r name exec_cmd icon <<<"${entries_ref[$file]}"
    if [ -f "$apps_dir/$file" ]; then
      echo "desktop entry $file already exists, skipping"
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
  install_desktop_entries
fi
