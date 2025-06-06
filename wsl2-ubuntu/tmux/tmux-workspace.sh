#!/bin/bash

# Check if there are enough arguments
if [ $# -lt 3 ]; then
	echo "Usage: $0 <source-file> <tmux-session-name> <panel-mode> (single or dual)"
  exit 1
fi

# Set the project directory
project_dir="/mnt/e/GALIH/project/$1"

# Check if the project directory exists
if [ ! -d "$project_dir" ]; then
  echo "Error: The project directory does not exist"
  exit 1
fi

# Set the source file
src_file=$1

# Set the tmux session name
session_name=$2

# panel mode
panel_mode=$3

#change directory to current project directory
cd "$project_dir"

# Start a new tmux session
tmux new-session -d -s "$session_name"

# Make window
tmux rename-window -t "$session_name":0 "Server"

if [ "$panel_mode" = "dual" ]; then
  # Make another window
  tmux new-window -t "$session_name":1 -n "Git and NPM"

  # Split the first window vertically
  tmux split-window -h -t "$session_name":0.0
  
  # Split the second window vertically
  tmux split-window -h -t "$session_name":1.0
elif [ "$panel_mode" = "single" ]; then
  #tmux another window
  tmux new-window -t "$session_name":1 -n "Git"
  
  #tmux another window
  tmux new-window -t "$session_name":2 -n "Npm"
else 
  echo "Panel mode is invalid, available option: single or dual"
  exit 1
fi

# Attach to the tmux session
tmux attach-session -t "$session_name"

