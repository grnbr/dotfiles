#!/bin/bash
SCRIPT="$HOME/dotfiles/src/configs/optional/bspwm/modules/displays-managment.sh"

# Wait until X is available.
until xrandr --query >/dev/null 2>&1; do
  sleep 1
done

while IFS= read -r line; do
  case "$line" in
  *RRScreenChangeNotify* | *RROutputChangeNotify* | *RRCrtcChangeNotify*)
    pkill picom
    while pgrep -x picom >/dev/null; do
      sleep 0.1
    done

    "$SCRIPT"

    ~/dotfiles/src/configs/optional/polybar/launch.sh
    picom --backend glx &
    ;;
  esac
done < <(xev -root -event randr 2>/dev/null)
