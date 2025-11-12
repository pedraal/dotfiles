#!/bin/bash

SESSION_NAME="__home__"

BORDERS_INSTALLED=false
SKETCHYBAR_INSTALLED=false
if command -v borders >/dev/null; then
    BORDERS_INSTALLED=true
fi
if command -v sketchybar >/dev/null; then
    SKETCHYBAR_INSTALLED=true
fi
RICEABLE=$($BORDERS_INSTALLED || $SKETCHYBAR_INSTALLED)

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    echo "Attaching to existing session '$SESSION_NAME'..."
    tmux attach-session -t "$SESSION_NAME"
else
    echo "Creating new session '$SESSION_NAME'..."

    cd ~

    tmux new-session -s "$SESSION_NAME" -n config -d
    tmux new-window -t "$SESSION_NAME" -n git
    if $RICEABLE; then
        tmux new-window -t "$SESSION_NAME" -n rice
    fi
    tmux new-window -t "$SESSION_NAME" -n exec

    if $RICEABLE; then
        tmux select-window -t "$SESSION_NAME":3
        if $BORDERS_INSTALLED; then
            tmux send-keys "borders" C-m
        fi
        if $SKETCHYBAR_INSTALLED; then
            tmux split-window -h -t "$SESSION_NAME":3
            tmux send-keys "sketchybar" C-m
        fi
    fi

    tmux select-window -t "$SESSION_NAME":2
    tmux send-keys "cd ~/dotfiles && lazygit" C-m

    tmux select-window -t "$SESSION_NAME":1
    tmux send-keys "cd ~/dotfiles && nvim" C-m

    tmux attach-session -t "$SESSION_NAME"
fi
