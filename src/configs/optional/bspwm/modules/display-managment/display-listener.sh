#!/bin/bash

SCRIPT="$HOME/dotfiles/src/configs/optional/bspwm/modules/display-managment/main.sh"
POLYBAR="$HOME/dotfiles/src/configs/optional/polybar/launch.sh"

until xrandr --query >/dev/null 2>&1; do
  sleep 1
done

get_state() {
  xrandr --query |
    awk '$2 == "connected" || $2 == "disconnected" {
            print $1, $2
        }' |
    sort
}

previous_state="$(get_state)"

while true; do
  current_state="$(get_state)"

  if [[ "$current_state" != "$previous_state" ]]; then
    "$SCRIPT"

    pkill -x polybar

    while pgrep -x polybar >/dev/null; do
      sleep 0.05
    done

    "$POLYBAR" &

    previous_state="$(get_state)"
  fi

  sleep 0.5
done
