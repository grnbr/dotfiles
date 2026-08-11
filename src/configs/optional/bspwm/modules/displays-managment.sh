#!/bin/bash

notify-send "$DISPLAY_CENTER"

bspc wm -O DP-0 DP-2
bspc monitor DP-0 -d I II IV VI VIII X
bspc monitor DP-2 -d III V VII IX
