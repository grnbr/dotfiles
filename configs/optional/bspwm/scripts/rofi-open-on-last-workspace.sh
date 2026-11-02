#!/usr/bin/env bash

sel=$(rofi -show drun \
  -kb-accept-entry "" -kb-accept-custom "" \
  -kb-custom-1 'Return' -kb-custom-2 'Control+Return')
code=$?
case $code in
10)
  focus=on
  follow=on
  ;; # Enter
11)
  focus=off
  follow=off
  ;; # Ctrl+Enter
*) exit 0 ;;
esac
[ -z "$sel" ] && exit 0
id=$(awk -F'\t' -v n="$sel" '$1==n{print $2; exit}' ~/.cache/rofi-app-index.tsv)
[ -z "$id" ] && exit 1

last_ws=$(bspc query -D -d last --names)
[ -z "$last_ws" ] && exit 1 # no "last" desktop exists yet (e.g. just logged in)

rofi-arm-rule "$last_ws" "$focus" "$follow"
gtk-launch "$id"
