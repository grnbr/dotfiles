#!/bin/bash
SCRIPT="$HOME/dotfiles/src/configs/optional/bspwm/modules/displays-managment.sh"

# Wait until X is available.
until xrandr --query >/dev/null 2>&1; do
  sleep 1
done

while IFS= read -r line; do
  case "$line" in
  *RRScreenChangeNotify* | *RROutputChangeNotify* | *RRCrtcChangeNotify*)
    "$SCRIPT"
    ~/dotfiles/src/configs/optional/polybar/launch.sh
    ;;
  esac
done < <(xev -root -event randr 2>/dev/null)
