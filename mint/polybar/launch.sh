#!/usr/bin/env bash

# Terminate already running bars
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar on each monitor
polybar mainbar &

if [[ $(xrandr -q | grep 'HDMI-1 connected') ]]; then
	polybar external &
fi

echo "Polybar launched on all monitors!"


polybar example &

