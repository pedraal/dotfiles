#!/bin/sh

source ./colors.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.color="$lavender"
else
    sketchybar --set $NAME background.color="$background"
fi
