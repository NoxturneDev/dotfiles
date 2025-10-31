#!/bin/bash

# Detect monitors
LAPTOP="eDP-1"
EXTERNAL="HDMI-1"

# Configure monitor layout
xrandr --output $EXTERNAL --auto --scale 1.0 --above $LAPTOP --output $LAPTOP --auto

# Reset desktops
bspc monitor $LAPTOP -d 1 2 3 4 5
bspc monitor $EXTERNAL -d 6 7 8 9 10
