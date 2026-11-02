#!/bin/bash
wid=$1
class=$2
instance=$3
consequences=$4

floating_apps=(Xfce-polkit gnome-calculator Xdg-desktop-portal-gtk Brave hiit pavucontrol Nm-connection-editor Blueman-manager)

is_floating() {
  local app
  for app in "${floating_apps[@]}"; do
    [[ "$class" == "$app" ]] && return 0
  done
  return 1
}

echo_assigned_app() {
  local desktop="$1"
  local focus="${2:-off}"
  echo "desktop=$desktop focus=on follow=$focus"
}

if is_floating; then
  echo "state=floating"
else
  case "$class" in
  Brave-browser | Chromium-browser)
    echo_assigned_app "I"
    ;;
  org.mozilla.firefox)
    echo_assigned_app "III"
    ;;
  kitty)
    kitty_count=$(
      bspc query -N -n .window |
        while read -r id; do
          xprop -id "$id" WM_CLASS 2>/dev/null
        done |
        grep -c '"kitty", "kitty"'
    )

    if ((kitty_count >= 1)); then
      exit 0
    else
      echo_assigned_app "II" "on"
    fi
    ;;
  TelegramDesktop | discord)
    echo_assigned_app "VIII"
    ;;
  # *)
  #   echo "desktop=X"
  #   ;;
  esac
fi
