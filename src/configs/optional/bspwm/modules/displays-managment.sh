#!/bin/bash

normalize_desktops() {
  local desired=(I II III IV V VI VII VIII IX X)
  local current=()

  mapfile -t current < <(bspc query -D --names)

  for ((i = 0; i < ${#desired[@]}; i++)); do

    # Already correct
    [[ "${current[i]}" == "${desired[i]}" ]] && continue

    # Find desired desktop later in the list
    for ((j = i + 1; j < ${#current[@]}; j++)); do

      if [[ "${current[j]}" == "${desired[i]}" ]]; then

        # Swap in bspwm
        bspc desktop "${current[i]}" -s "${current[j]}"

        # Swap our local representation too
        local tmp="${current[i]}"
        current[i]="${current[j]}"
        current[j]="$tmp"

        break
      fi

    done
  done
}

manage_displays() {
  if [ -f "$HOME/.bspwm_displays" ]; then
    . "$HOME/.bspwm_displays"
  else
    notify-send -u critical -t 0 "postswitch" "~/.bspwm_displays not found — aborting"
    exit 1
  fi

  # desktop groups
  TRIPLE_LEFT="III V VII"
  TRIPLE_CENTER="I II IV X"
  TRIPLE_RIGHT="VI VIII"

  DUAL_SIDE="III V VII IX"
  DUAL_CENTER="I II IV VI VIII X"

  SINGLE_ALL="I II III IV V VI VII VIII IX X"

  is_connected() {
    [[ -n "$1" ]] && xrandr -q | grep -q "^$1 connected"
  }

  L=0
  C=0
  R=0
  is_connected "$DISPLAY_LEFT" && L=1
  is_connected "$DISPLAY_CENTER" && C=1
  is_connected "$DISPLAY_RIGHT" && R=1
  echo "$L, $C, $R"

  pkill picom
  while pgrep -x picom >/dev/null; do
    sleep 0.1
  done

  if [[ $L == 1 && $C == 1 && $R == 1 ]]; then

    # triple — center primary

    xrandr \
      --output "$DISPLAY_CENTER" --auto --primary \
      --output "$DISPLAY_LEFT" --auto --left-of "$DISPLAY_CENTER" \
      --output "$DISPLAY_RIGHT" --auto --right-of "$DISPLAY_CENTER"

    bspc wm -O "$DISPLAY_LEFT" "$DISPLAY_CENTER" "$DISPLAY_RIGHT"

    for desktop in $TRIPLE_LEFT; do
      bspc desktop "$desktop" -m "$DISPLAY_LEFT"
    done

    for desktop in $TRIPLE_CENTER; do
      bspc desktop "$desktop" -m "$DISPLAY_CENTER"
    done

    for desktop in $TRIPLE_RIGHT; do
      bspc desktop "$desktop" -m "$DISPLAY_RIGHT"
    done

  elif [[ $L == 1 && $R == 1 && $C == 0 ]]; then

    # left + right — left primary

    xrandr \
      --output "$DISPLAY_LEFT" --auto --primary \
      --output "$DISPLAY_RIGHT" --auto --right-of "$DISPLAY_LEFT"

    bspc wm -O "$DISPLAY_LEFT" "$DISPLAY_RIGHT"

    for desktop in $DUAL_CENTER; do
      bspc desktop "$desktop" -m "$DISPLAY_LEFT"
    done

    for desktop in $DUAL_SIDE; do
      bspc desktop "$desktop" -m "$DISPLAY_RIGHT"
    done

  elif [[ $C == 1 && $L == 1 && $R == 0 ]]; then

    # center + left — center primary

    xrandr \
      --output "$DISPLAY_CENTER" --auto --primary \
      --output "$DISPLAY_LEFT" --auto --left-of "$DISPLAY_CENTER"

    bspc wm -O "$DISPLAY_LEFT" "$DISPLAY_CENTER"

    for desktop in $DUAL_SIDE; do
      bspc desktop "$desktop" -m "$DISPLAY_LEFT"
    done

    for desktop in $DUAL_CENTER; do
      bspc desktop "$desktop" -m "$DISPLAY_CENTER"
    done

  elif [[ $C == 1 && $R == 1 && $L == 0 ]]; then

    # center + right — center primary

    xrandr \
      --output "$DISPLAY_CENTER" --auto --primary \
      --output "$DISPLAY_RIGHT" --auto --right-of "$DISPLAY_CENTER"

    bspc wm -O "$DISPLAY_CENTER" "$DISPLAY_RIGHT"

    for desktop in $DUAL_CENTER; do
      bspc desktop "$desktop" -m "$DISPLAY_CENTER"
    done

    for desktop in $DUAL_SIDE; do
      bspc desktop "$desktop" -m "$DISPLAY_RIGHT"
    done

  elif [[ $L == 1 && $C == 0 && $R == 0 ]]; then

    # left only

    xrandr \
      --output "$DISPLAY_LEFT" --auto --primary --pos 0x0

    bspc wm -O "$DISPLAY_LEFT"

    for desktop in $SINGLE_ALL; do
      bspc desktop "$desktop" -m "$DISPLAY_LEFT"
    done

    normalize_desktops

  elif [[ $C == 1 && $L == 0 && $R == 0 ]]; then

    # center only

    xrandr \
      --output "$DISPLAY_CENTER" --auto --primary --pos 0x0

    bspc wm -O "$DISPLAY_CENTER"

    for desktop in $SINGLE_ALL; do
      bspc desktop "$desktop" -m "$DISPLAY_CENTER"
    done

    normalize_desktops

  elif [[ $R == 1 && $L == 0 && $C == 0 ]]; then

    # right only

    xrandr \
      --output "$DISPLAY_RIGHT" --auto --primary --pos 0x0

    bspc wm -O "$DISPLAY_RIGHT"

    for desktop in $SINGLE_ALL; do
      bspc desktop "$desktop" -m "$DISPLAY_RIGHT"
    done

    normalize_desktops
  fi

  bspc desktop Desktop -r
  picom --backend glx &

  ~/dotfiles/src/configs/optional/polybar/launch.sh
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  manage_displays
fi
