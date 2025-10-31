#!/usr/bin/env bash

# Exit if tmux session already exists
tmux has-session -t coding 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Tmux sessions already exist. Attach with: tmux attach -t coding"
  exit 0
fi

### SESSION 1: CODING WORKSPACE ###
tmux new-session -d -s coding -n frontend -c ~/projects/ziad/frontend/ziad-react-template
tmux send-keys -t coding:frontend 'nvim .' C-m

tmux new-window -t coding:1 -n backend -c ~/projects/ziad/backend/ziad-laravel-template
tmux send-keys -t coding:backend 'nvim .' C-m

tmux new-window -t coding:2 -n cli -c ~/projects/ziad/backend/ziad-laravel-template
tmux split-window -h -t coding:2 -c ~/projects/ziad/frontend/ziad-react-template


### SESSION 2: DOCKER MONITORING ###
tmux new-session -d -s docker -n docker-monitor -c ~/projects/ziad/backend/ziad-laravel-template
tmux split-window -h -t docker:0 -c ~/projects/ziad/frontend/ziad-react-template

tmux new-window -t docker:1 -n docker-exec -c ~/projects/ziad/backend/ziad-laravel-template
tmux split-window -h -t docker:1 -c ~/projects/ziad/frontend/ziad-react-template

tmux new-window -t docker:2 -n docker-config -c ~/projects/ziad/backend/ziad-laravel-template
tmux split-window -h -t docker:2 -c ~/projects/ziad/frontend/ziad-react-template


### SESSION 3: SSH CONNECTIONS ###
tmux new-session -d -s ssh -n ssh -c ~
tmux split-window -h -t ssh:0 -c ~/projects/ziad/backend

tmux new-window -t ssh:1 -n FE-patch -c ~/projects/ziad/frontend/ziad-react-template
tmux split-window -h -t ssh:1 -c ~/projects/ziad/frontend/ziad-react-template

tmux new-window -t ssh:2 -n PROD -c ~/projects/ziad/automation
tmux split-window -h -t ssh:2 -c ~/projects/ziad/automation


### Final setup ###
tmux select-window -t coding:0
tmux attach-session -t coding

