#!/bin/bash
# Swap current tmux session with adjacent one (left=prev, right=next)
# Usage: swap-sessions.sh <current-session-name> <direction>

current="$1"
direction="$2"

# Get ordered list of session names
sessions=($(tmux list-sessions -F "#{session_name}" 2>/dev/null))
count=${#sessions[@]}

if [ "$count" -le 1 ]; then
    exit 0
fi

# Find current index
idx=-1
for i in "${!sessions[@]}"; do
    if [ "${sessions[$i]}" = "$current" ]; then
        idx=$i
        break
    fi
done

if [ "$idx" -eq -1 ]; then
    exit 1
fi

# Calculate target
if [ "$direction" = "left" ]; then
    target=$((idx - 1))
    [ $target -lt 0 ] && target=$((count - 1))
else
    target=$((idx + 1))
    [ $target -ge $count ] && target=0
fi

src_name="${sessions[$idx]}"
dst_name="${sessions[$target]}"

# Swap via temporary rename
tmux rename-session -t "$src_name" "__swap_tmp__" &&
tmux rename-session -t "$dst_name" "$src_name" &&
tmux rename-session -t "__swap_tmp__" "$dst_name"
