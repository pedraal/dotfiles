#!/usr/bin/env bash

source ./colors.sh

RAM_PERCENT=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')

case "$RAM_PERCENT" in
  [7-9][0-9]|100) BG_COLOR="$red"
  ;;
  [3-6][0-9]) BG_COLOR="$peach"
  ;;
  *) BG_COLOR="$green"
esac

sketchybar -m --set ram_label label="${RAM_PERCENT}%" --set ram_icon background.color="$BG_COLOR"
