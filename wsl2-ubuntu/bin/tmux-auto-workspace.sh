#!/bin/bash

# Set the project directory
project_dir="/home/noxturnedev/projects"
notes_dir="/mnt/c/Users/galih/Documents/Second Brain/notes/ZIAD"

# Create ziad-prod session
tmux new-session -d -s "ziad-prod" -n "ssh"

# SSH tab
tmux send-keys -t "ziad-prod:0.0" "cat patching-be.txt" Enter
tmux split-window -h -t "ziad-prod:0"

# Patch-demo tab
tmux new-window -t "ziad-prod" -n "patch-demo"
tmux send-keys -t "ziad-prod:1.0" "cd /home/noxturnedev/ziad-automation/ansible" C-m
tmux split-window -h -t "ziad-prod:1"
tmux send-keys -t "ziad-prod:1.1" "cd /home/noxturnedev/projects/ziad/ziad-react-template" C-m

# Patch-clients tab
tmux new-window -t "ziad-prod" -n "patch-clients"
tmux send-keys -t "ziad-prod:2.0" "cd /home/noxturnedev/ziad-automation/ansible" C-m
tmux split-window -h -t "ziad-prod:2"
tmux send-keys -t "ziad-prod:2.1" "cd /home/noxturnedev/projects/ziad/ziad-react-template" C-m

# Patch-config tab
tmux new-window -t "ziad-prod" -n "patch-config"
tmux send-keys -t "ziad-prod:3.0" "cd ~/ziad-automation/ansible && nvim ." C-m
tmux split-window -h -t "ziad-prod:3"
tmux send-keys -t "ziad-prod:3.1" "cd ~/ziad-automation/ansible" C-m

# Front-end tab with 4 panes
tmux new-window -t "ziad-prod" -n "front-end"
tmux send-keys -t "ziad-prod:4.0" "cd /home/noxturnedev/projects/ziad/ziad-react-template" C-m
tmux split-window -h -t "ziad-prod:4"
tmux send-keys -t "ziad-prod:4.1" "cd /home/noxturnedev/projects/ziad/ziad-react-template" C-m
tmux split-window -v -t "ziad-prod:4.0"
tmux send-keys -t "ziad-prod:4.2" "cd /home/noxturnedev/projects/ziad/ziad-react-template" C-m
tmux split-window -v -t "ziad-prod:4.1"
tmux send-keys -t "ziad-prod:4.3" "cd /home/noxturnedev/projects/ziad/ziad-react-template" C-m

# Start session 2: laboratory
cd $project_dir
tmux new-session -d -s "laboratory"
tmux rename-window -t "laboratory":0 "root"

cd $project_dir
tmux new-session -d -s "docker"
tmux rename-window -t "docker":0 "docker monitor"
tmux new-window -t "docker":1 -n "docker-lab-workspace"
tmux new-window -t "docker":2 -n "tmux-help"

# Start session 2: laboratory
cd $project_dir
tmux new-session -d -s "projects"
tmux rename-window -t "project":0 "dir"

cd $project_dir
tmux new-session -d -s "notes"
tmux rename-window -t "notes":0 "nvim"
tmux send-keys 'nvim .' Enter

tmux attach-session -t "ziad-prod"
# echo message
echo -e "\xf0\x9f\x9a\x80 Workspace created, happy coding"
