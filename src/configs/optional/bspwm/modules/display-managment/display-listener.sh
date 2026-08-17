#!/bin/bash
SCRIPT="$HOME/dotfiles/src/configs/optional/bspwm/modules/display-managment/main.sh"

# Wait until X is available.
until xrandr --query >/dev/null 2>&1; do
  sleep 1
done

previous_state="$(
  xrandr --query |
    awk '$2 == "connected" || $2 == "disconnected" {
      print $1, $2
    }' |
    sort
)"

while true; do
  current_state="$(
    xrandr --query |
      awk '$2 == "connected" || $2 == "disconnected" {
        print $1, $2
      }' |
      sort
  )"

  if [[ "$current_state" != "$previous_state" ]]; then
    # pkill picom

    # while pgrep -x picom >/dev/null; do
    #   sleep 0.1
    # done

    "$SCRIPT"

    "$HOME/dotfiles/src/configs/optional/polybar/launch.sh" &
    # picom --backend glx &
    previous_state="$current_state"
  fi

  sleep 0.5
done
