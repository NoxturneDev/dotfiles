#!/bin/bash
# Start a new tmux session
tmux new-session -d -s "patching-be"

# tmux new window
tmux new-window -t "$session_name" -n "server-51"
tmux new-window -t "$session_name" -n "server-131"
tmux new-window -t "$session_name" -n "server-78"
tmux new-window -t "$session_name" -n "server-10"
tmux new-window -t "$session_name" -n "server-235"
tmux new-window -t "$session_name" -n "server-97"
tmux new-window -t "$session_name" -n "server-143"

# Attach to the tmux session
tmux attach-session -t "patching-be"

