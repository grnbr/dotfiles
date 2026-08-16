#!/bin/bash

systemctl --user start bspwm-session.target

. "$HOME/dotfiles/src/configs/optional/bspwm/src/desktop_constants.sh"

if [ -n "$DISPLAY_CENTER" ] &&
  xrandr --query | grep -q "^${DISPLAY_CENTER} connected"; then

  bspc wm -O "$DISPLAY_CENTER"

  # Create desktops only if they don't already exist.
  if ! bspc query -D --names | grep -qx 'X'; then
    bspc monitor "$DISPLAY_CENTER" -d "${DESKTOPS[@]}"
  fi

  "$HOME/dotfiles/src/configs/optional/bspwm/modules/display-managment/main.sh"

  if ! systemctl --user is-active --quiet bspwm-displays.service; then
    systemctl --user start bspwm-displays.service
  fi
else
  notify-send -t 0 "Display Manager" \
    "Center display '$DISPLAY_CENTER' is not connected"
fi

pkill -x sxhkd
pkill -x picom
pkill -x xfce-polkit
pkill -x xautolock
pkill -x xss-lock

xset r rate 200 35 &
setxkbmap -layout us,ru -option grp:win_space_toggle &
/usr/libexec/xfce-polkit &
xss-lock --transfer-sleep-lock -- i3lock -c 1e1e1e -n &
xautolock -time 10 -locker "i3lock -c 1e1e1e" &

if lspci | grep -qi nvidia; then
  picom --config ~/.config/picom/picom-nvidia.conf &
else
  picom --config ~/.config/picom/picom.conf &
fi

sxhkd &
"$HOME/dotfiles/src/configs/optional/polybar/launch.sh" &

pgrep -f "org.telegram.desktop" >/dev/null || flatpak run org.telegram.desktop &
pgrep -f "com.discordapp.Discord" >/dev/null || flatpak run com.discordapp.Discord &
pgrep -f "brave-browser" >/dev/null || brave-browser --incognito &
pgrep -x firefox >/dev/null || firefox -P "Main" --no-remote &
pgrep -x kitty >/dev/null || kitty &
