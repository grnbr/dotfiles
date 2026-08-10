#!/bin/bash
wid=$1
class=$2
instance=$3
consequences=$4

floating_apps=(Xfce-polkit Gnome-calculator Xdg-desktop-portal-gtk)

is_floating() {
  local app
  for app in "${floating_apps[@]}"; do
    [[ "$class" == "$app" ]] && return 0
  done
  return 1
}

if is_floating; then
  echo "state=floating"
else
  case "$class" in
  Brave-browser | Chromium-browser)
    echo "desktop=IV"
    ;;
  org.mozilla.firefox)
    echo "desktop=III"
    ;;
  kitty)
    echo "desktop=II"
    ;;
  TelegramDesktop | discord)
    echo "desktop=VIII"
    ;;
  *)
    echo "desktop=X"
    ;;
  esac
fi
