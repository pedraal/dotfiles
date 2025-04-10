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

    # Create the main session with a window named 'perf'
    tmux new-session -s "$SESSION_NAME" -n perf -d

    # Create additional windows
    tmux new-window -t "$SESSION_NAME" -n borders
    tmux new-window -t "$SESSION_NAME" -n exec

    # Configure the 'borders' window (window 2)
    tmux select-window -t "$SESSION_NAME":2
    tmux send-keys "borders" C-m

    # Configure the 'perf' window (window 1)
    tmux select-window -t "$SESSION_NAME":1
    tmux send-keys "btm" C-m

    # Attach to the session
    tmux attach-session -t "$SESSION_NAME"
fi
