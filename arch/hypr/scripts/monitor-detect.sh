#!/usr/bin/env bash

# Wait a bit to ensure Hyprland has registered the change
sleep 1

# Get connected monitors
MONITORS=$(hyprctl monitors | grep "Monitor" | awk '{print $2}')

# Default configuration: only laptop
LAPTOP="eDP-1"
EXTERNAL="HDMI-A-1"

# Check if HDMI monitor is connected
# top bottom setup
echo "External monitor detected. Configuring dual setup..."
if hyprctl monitors | grep -q "$EXTERNAL"; then
  hyprctl keyword monitor "$EXTERNAL,1920x1080@74.97,0x-1080,1"
  hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1"
else
  echo "External monitor not detected. Switching to laptop only..."
  hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1"
fi

# left and right setup
# if hyprctl monitors | grep -q "$EXTERNAL"; then
#   echo "External monitor detected. Configuring side-by-side setup..."
#
#   hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1"
#   hyprctl keyword monitor "$EXTERNAL,1920x1080@74.97,1920x0,1"
#
# else
#   echo "External monitor not detected. Laptop only..."
#   hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1.25"
# fi

# echo "External monitor detected. Configuring dual setup..."
# if hyprctl monitors | grep -q "$EXTERNAL"; then
#   hyprctl keyword monitor "$EXTERNAL,1080x1920@74.97,-1080x0,1"
#   hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1"
# else
#   echo "External monitor not detected. Switching to laptop only..."
#   hyprctl keyword monitor "$LAPTOP,1920x1080@60,0x0,1"
# fi
