#!/bin/bash

if xrandr | grep "HDMI-1 connected"; then
  ~/.config/bspwm/monitors/dual.sh
else
  ~/.config/bspwm/monitors/single.sh
fi

killall -q picom
picom -b --backend xrender --config ~/.config/picom/picom.conf

feh --bg-scale ~/Downloads/1205979.png
