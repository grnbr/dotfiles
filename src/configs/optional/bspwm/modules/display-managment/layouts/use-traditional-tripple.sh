#!/bin/bash

use_traditional_tripple() {
  . /home/worromot/dotfiles/src/configs/optional/bspwm/src/desktop_constants.sh

  if [ -f "$HOME/.bspwm_displays" ]; then
    . "$HOME/.bspwm_displays"
  else
    notify-send -t 0 "Displays Managment" "~/.bspwm_displays not found — aborting"
    exit 1
  fi

  if [[ -z "$DISPLAY_CENTER" && -z "$DISPLAY_LEFT" && -z "$DISPLAY_RIGHT" ]]; then
    notify-send -t 0 "Displays Management" "No displays configured"
    exit 1
  fi

  is_connected() {
    [[ -n "$1" ]] && xrandr -q | grep -q "^$1 connected"
  }

  L=0
  C=0
  R=0

  is_connected "$DISPLAY_LEFT" && L=1
  is_connected "$DISPLAY_CENTER" && C=1
  is_connected "$DISPLAY_RIGHT" && R=1

  local -r CONNECTED_DISPLAYS_AMOUNT=$((L + C + R))

  if ((CONNECTED_DISPLAYS_AMOUNT == 1)); then
    local connected_display=""

    if ((L == 1)); then
      connected_display="$DISPLAY_LEFT"
    elif ((C == 1)); then
      connected_display="$DISPLAY_CENTER"
    elif ((R == 1)); then
      connected_display="$DISPLAY_RIGHT"
    fi

    xrandr \
      --output "$connected_display" --auto --primary --pos 0x0

    bspc wm -O "$connected_display"

    for desktop in "${DESKTOPS[@]}"; do
      bspc desktop "$desktop" -m "$connected_display"
    done

    bspc monitor "$connected_display" -o "${DESKTOPS[@]}"

  else

    local -ar excluded_primary_desktops=("${DESKTOPS[0]}" "${DESKTOPS[-1]}")

    local -a body_desktops=("${DESKTOPS[@]:1:${#DESKTOPS[@]}-2}") # II III IV V VI VII VIII IX
    local -r body_length=${#body_desktops[@]}

    local remainder=$((body_length % CONNECTED_DISPLAYS_AMOUNT))
    local -r desktops_amount=$((body_length / CONNECTED_DISPLAYS_AMOUNT))

    local -r primary_desktops_amount="$desktops_amount"
    local -a side_desktops_amounts=()

    for ((i = 0; i < CONNECTED_DISPLAYS_AMOUNT - 1; i++)); do
      side_desktops_amounts+=("$desktops_amount")
    done

    local i=0

    while ((remainder > 0)); do
      ((side_desktops_amounts[i]++))
      ((remainder--))

      ((i++))

      if ((i >= ${#side_desktops_amounts[@]})); then
        i=0
      fi
    done

    local -a primary_body_desktops=()
    local -a left_desktops=()
    local -a right_desktops=()

    local primary_count=0
    local left_count=0

    for ((i = 0; i < ${#body_desktops[@]}; i++)); do
      if ((i % 2 == 0 && primary_count < primary_desktops_amount)); then
        primary_body_desktops+=("${body_desktops[i]}")
        ((primary_count++))
      elif ((i % 2 == 1 && left_count < side_desktops_amounts[0])); then
        left_desktops+=("${body_desktops[i]}")
        ((left_count++))
      else
        right_desktops+=("${body_desktops[i]}")
      fi
    done

    local -a primary_desktops=(
      "${excluded_primary_desktops[0]}"
      "${primary_body_desktops[@]}"
      "${excluded_primary_desktops[1]}"
    )

    if ((CONNECTED_DISPLAYS_AMOUNT == 2)); then

      if ((L && C)); then
        xrandr \
          --output "$DISPLAY_CENTER" --auto --primary \
          --output "$DISPLAY_LEFT" --auto --left-of "$DISPLAY_CENTER"

        bspc wm -O \
          "$DISPLAY_LEFT" \
          "$DISPLAY_CENTER"

        for desktop in "${left_desktops[@]}"; do
          bspc desktop "$desktop" -m "$DISPLAY_LEFT"
        done

        for desktop in "${primary_desktops[@]}"; do
          bspc desktop "$desktop" -m "$DISPLAY_CENTER"
        done

        bspc monitor "$DISPLAY_LEFT" -o "${left_desktops[@]}"
        bspc monitor "$DISPLAY_CENTER" -o "${primary_desktops[@]}"

      elif ((R && C)); then
        xrandr \
          --output "$DISPLAY_CENTER" --auto --primary \
          --output "$DISPLAY_RIGHT" --auto --right-of "$DISPLAY_CENTER"

        bspc wm -O \
          "$DISPLAY_CENTER" \
          "$DISPLAY_RIGHT"

        for desktop in "${primary_desktops[@]}"; do
          bspc desktop "$desktop" -m "$DISPLAY_CENTER"
        done

        for desktop in "${left_desktops[@]}"; do
          bspc desktop "$desktop" -m "$DISPLAY_RIGHT"
        done

        bspc monitor "$DISPLAY_CENTER" -o "${primary_desktops[@]}"
        bspc monitor "$DISPLAY_RIGHT" -o "${left_desktops[@]}"

      elif ((L && R)); then
        xrandr \
          --output "$DISPLAY_LEFT" --auto --primary \
          --output "$DISPLAY_RIGHT" --auto --right-of "$DISPLAY_LEFT"

        bspc wm -O \
          "$DISPLAY_LEFT" \
          "$DISPLAY_RIGHT"

        for desktop in "${primary_desktops[@]}"; do
          bspc desktop "$desktop" -m "$DISPLAY_LEFT"
        done

        for desktop in "${left_desktops[@]}"; do
          bspc desktop "$desktop" -m "$DISPLAY_RIGHT"
        done

        bspc monitor "$DISPLAY_LEFT" -o "${primary_desktops[@]}"
        bspc monitor "$DISPLAY_RIGHT" -o "${left_desktops[@]}"
      fi

    elif ((CONNECTED_DISPLAYS_AMOUNT == 3)); then
      xrandr \
        --output "$DISPLAY_CENTER" --auto --primary \
        --output "$DISPLAY_LEFT" --auto --left-of "$DISPLAY_CENTER" \
        --output "$DISPLAY_RIGHT" --auto --right-of "$DISPLAY_CENTER"

      bspc wm -O \
        "$DISPLAY_LEFT" \
        "$DISPLAY_CENTER" \
        "$DISPLAY_RIGHT"

      for desktop in "${left_desktops[@]}"; do
        bspc desktop "$desktop" -m "$DISPLAY_LEFT"
      done

      for desktop in "${primary_desktops[@]}"; do
        bspc desktop "$desktop" -m "$DISPLAY_CENTER"
      done

      for desktop in "${right_desktops[@]}"; do
        bspc desktop "$desktop" -m "$DISPLAY_RIGHT"
      done

      bspc monitor "$DISPLAY_LEFT" -o "${left_desktops[@]}"
      bspc monitor "$DISPLAY_CENTER" -o "${primary_desktops[@]}"
      bspc monitor "$DISPLAY_RIGHT" -o "${right_desktops[@]}"
    fi
  fi

  bspc desktop Desktop -r
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  use_traditional_tripple
fi
