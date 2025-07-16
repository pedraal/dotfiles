#!/bin/bash

# Script name: init_home_session.sh
# Description: Creates or attaches to a tmux session named "__home__" with
#              specific windows and applications

# Session name
SESSION_NAME="__home__"

# Check if the session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # If it exists, attach to it
    echo "Attaching to existing session '$SESSION_NAME'..."
    tmux attach-session -t "$SESSION_NAME"
else
    # If it doesn't exist, create a new session with the specified configuration
    echo "Creating new session '$SESSION_NAME'..."

    tmux new-session -s "$SESSION_NAME" -n config -d
    tmux new-window -t "$SESSION_NAME" -n git
    tmux new-window -t "$SESSION_NAME" -n rice
    tmux new-window -t "$SESSION_NAME" -n exec

    tmux select-window -t "$SESSION_NAME":3
    tmux send-keys "borders" C-m
    tmux split-window -h -t "$SESSION_NAME":3
    tmux send-keys "sketchybar" C-m
    tmux split-window -h -t "$SESSION_NAME":3
    tmux send-keys "sketchybar --hotload true" C-m

    tmux select-window -t "$SESSION_NAME":2
    tmux send-keys "cd ~/.config && lazygit" C-m

    tmux select-window -t "$SESSION_NAME":1
    tmux send-keys "cd ~/.config && nvim" C-m

    tmux attach-session -t "$SESSION_NAME"
fi
