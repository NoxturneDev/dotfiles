#!/bin/bash

LAPTOP="eDP-1"

# Configure single monitor
xrandr --output $LAPTOP --auto --primary

# Move all desktops to the laptop
bspc monitor $LAPTOP -d 1 2 3 4 5 6 7 8 9 10
