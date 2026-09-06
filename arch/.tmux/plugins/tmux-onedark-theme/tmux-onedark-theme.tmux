#!/bin/bash
#onedark_black="#282c34"
#onedark_blue="#61afef"
#onedark_yellow="#e5c07b"
#onedark_red="#e06c75"
#onedark_white="#aab2bf"
#onedark_green="#98c379"
#onedark_visual_grey="#3e4452"
#onedark_comment_grey="#5c6370"

# catpuchin
onedark_black="#1e1e2e"
onedark_blue="#89b4fa"
onedark_yellow="#f9e2af"
onedark_red="#f38ba8"
onedark_white="#cdd6f4"
onedark_green="#a6e3a1"
onedark_visual_grey="#313244"
onedark_comment_grey="#6c7086"

# (Optional: extra polish)
set -g message-style "bg=#89b4fa,fg=#1e1e2e"
set -g pane-active-border-style "fg=#89b4fa"
set -g pane-border-style "fg=#313244"
set -g status-bg "#1e1e2e"
set -g status-fg "#cdd6f4"

get() {
  local option=$1
  local default_value=$2
  local option_value="$(tmux show-option -gqv "$option")"

  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

set() {
  local option=$1
  local value=$2
  tmux set-option -gq "$option" "$value"
}

setw() {
  local option=$1
  local value=$2
  tmux set-window-option -gq "$option" "$value"
}

set "status" "on"
set "status-justify" "left"

set "status-left-length" "100"
set "status-right-length" "100"
set "status-right-attr" "none"

set "message-fg" "$onedark_white"
set "message-bg" "$onedark_black"

set "message-command-fg" "$onedark_white"
set "message-command-bg" "$onedark_black"

set "status-attr" "none"
set "status-left-attr" "none"

setw "window-status-fg" "$onedark_black"
setw "window-status-bg" "$onedark_black"
setw "window-status-attr" "none"

setw "window-status-activity-bg" "$onedark_black"
setw "window-status-activity-fg" "$onedark_black"
setw "window-status-activity-attr" "none"

setw "window-status-separator" ""

set "window-style" "fg=$onedark_comment_grey"
set "window-active-style" "fg=$onedark_white"

set "pane-border-fg" "$onedark_white"
set "pane-border-bg" "$onedark_black"
set "pane-active-border-fg" "$onedark_blue"
set "pane-active-border-bg" "$onedark_black"

set "display-panes-active-colour" "$onedark_white"
set "display-panes-colour" "$onedark_blue"

set "status-bg" "$onedark_black"
set "status-fg" "$onedark_white"

set "@prefix_highlight_fg" "$onedark_black"
set "@prefix_highlight_bg" "$onedark_blue"
set "@prefix_highlight_copy_mode_attr" "fg=$onedark_black,bg=$onedark_blue"
set "@prefix_highlight_output_prefix" "  "

status_widgets=$(get "@onedark_widgets")
time_format=$(get "@onedark_time_format" "%R")
date_format=$(get "@onedark_date_format" "%d/%m/%Y")

set "status-right" "#[fg=$onedark_white,bg=$onedark_black,nounderscore,noitalics]${time_format}  ${date_format} #[fg=$onedark_visual_grey,bg=$onedark_black]#[fg=$onedark_visual_grey,bg=$onedark_visual_grey]#[fg=$onedark_white, bg=$onedark_visual_grey]${status_widgets} #[fg=$onedark_blue,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_black,bg=$onedark_blue,bold] #h #[fg=$onedark_yellow, bg=$onedark_blue]#[fg=$onedark_red,bg=$onedark_yellow]"
set "status-left" "#[fg=$onedark_black,bg=$onedark_blue,bold] #S #{prefix_highlight}#[fg=$onedark_blue,bg=$onedark_black,nobold,nounderscore,noitalics]"

set "window-status-format" "#[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_black] #I  #W #[fg=$onedark_black,bg=$onedark_black,nobold,nounderscore,noitalics]"
set "window-status-current-format" "#[fg=$onedark_black,bg=$onedark_visual_grey,nobold,nounderscore,noitalics]#[fg=$onedark_white,bg=$onedark_visual_grey,nobold] #I  #W #[fg=$onedark_visual_grey,bg=$onedark_black,nobold,nounderscore,noitalics]"
