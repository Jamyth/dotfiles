#!/bin/bash

if [[ -z "$DACS" ]]; then
    selected=$(find ~ ~/Desktop/work/projects -mindepth 1 -maxdepth 1 -type d | fzf)
else
    if [[ -n "$1" && -d "$DACS/Desktop/work/$1" ]]; then
        selected="$DACS/Desktop/work/$1"
    else
        selected=$(find $DACS/Desktop/work -mindepth 1 -maxdepth 1 -type d | fzf)
    fi
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)


if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
