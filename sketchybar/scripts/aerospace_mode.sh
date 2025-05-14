#!/bin/sh

source ./colors.sh

if [ "service" = "$MODE" ]; then
    sketchybar --set aerospace_mode background.color="$red"
else
    sketchybar --set aerospace_mode background.color="$blue"
fi
