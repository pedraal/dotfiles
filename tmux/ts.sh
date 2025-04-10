#!/bin/bash

# Get the current directory name
SESSION_NAME=$(basename "$PWD")

# Check if the session already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # If it exists, attach to it
    tmux attach-session -t "$SESSION_NAME"
else
    # If it doesn't exist, create a new session with the specified configuration
    tmux new-session -s "$SESSION_NAME" -n code \; \
        new-window -n exec \; \
        new-window -n git \; \
        select-window -t 3 \; \
        send-keys "lazygit" C-m \; \
        select-window -t 1 \; \
        send-keys "nvim" C-m
fi
