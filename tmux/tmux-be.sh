#!/bin/bash

# Check if there are enough arguments
if [ $# -lt 1 ]; then
  echo "Usage: $0 <source-file>"
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

#change directory to current project directory
cd "$project_dir"

# Start a new tmux session
tmux new-session -d -s tmux-server

# Make window
tmux rename-window -t tmux-server:0 "Server"

# Split the first window vertically
tmux split-window -h -t tmux-server:0.0

# Make another window
tmux new-window -t tmux-server:1 -n "Git and NPM"

# Split the second window vertically
tmux split-window -h -t tmux-server:1.0


# Attach to the tmux session
tmux attach-session -t tmux-server





