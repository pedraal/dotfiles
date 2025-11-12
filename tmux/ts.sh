#!/bin/bash

SESSION_NAME=$(basename "$PWD" | tr '.' '_')

if tmux has-session -t "=$SESSION_NAME" 2>/dev/null; then
    tmux attach-session -t "$SESSION_NAME"
else
    if [ -d ".git" ]; then
        tmux new-session -s "$SESSION_NAME" -n code \; \
            new-window -n exec \; \
            new-window -n git \; \
            select-window -t 3 \; \
            send-keys "lazygit" C-m \; \
            select-window -t 1 \; \
            send-keys "nvim" C-m
    else
        tmux new-session -s "$SESSION_NAME" -n code \; \
            new-window -n exec \; \
            select-window -t 1 \; \
            send-keys "nvim" C-m
    fi
fi
