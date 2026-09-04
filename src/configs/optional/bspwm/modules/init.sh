#!/bin/bash

systemctl --user start bspwm-session.target

. "$HOME/dotfiles/src/configs/optional/bspwm/desktop_constants.sh"

if ! bspc query -D -d "${DESKTOPS[0]}" >/dev/null 2>&1; then
  bspc monitor -d "${DESKTOPS[@]}"
fi

if [ -f "$HOME/.config/.bspwm_displays" ]; then
  "$HOME/dotfiles/src/configs/optional/bspwm/modules/display-managment/main.sh"
  if ! systemctl --user is-active --quiet bspwm-displays.service; then
    systemctl --user start bspwm-displays.service
  fi
else
  notify-send -t 0 "Display Manager" \
    "No display configuration. Make it in .config/bspwm_displays. You can also copy it from bspwm/modules/display-managment/.bspwm_displays.example"
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

if systemd-detect-virt --quiet; then
  :
elif lspci | grep -qi nvidia; then
  picom --config ~/.config/picom/picom-nvidia.conf &
else
  picom --config ~/.config/picom/picom.conf &
fi

bspc config external_rules_command ${HOME}/dotfiles/src/configs/optional/bspwm/modules/external_rules.sh

sxhkd &
"$HOME/dotfiles/src/configs/optional/polybar/launch.sh" &

pgrep -x nm-applet >/dev/null || nm-applet &
pgrep -f "org.telegram.desktop" >/dev/null || flatpak run org.telegram.desktop &
pgrep -f "com.discordapp.Discord" >/dev/null || flatpak run com.discordapp.Discord &
pgrep -f "brave-browser" >/dev/null || brave-browser --incognito &
if ! pgrep -x firefox >/dev/null; then
  if grep -q '^Name=Main$' "$HOME/.mozilla/firefox/profiles.ini" 2>/dev/null; then
    firefox -P "Main" --no-remote &
  else
    firefox &
  fi
fi

pgrep -x kitty >/dev/null || kitty &

systemctl --user restart darkman
