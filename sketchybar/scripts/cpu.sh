#!/usr/bin/env bash

source ./colors.sh

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENT=$(echo "$CPU_SYS $CPU_USER" | awk '{ printf("%02.0f\n", ($1 + $2)*100) }')

case "$CPU_PERCENT" in
  [7-9][0-9]|100) BG_COLOR="$red"
  ;;
  [3-6][0-9]) BG_COLOR="$peach"
  ;;
  *) BG_COLOR="$green"
esac

sketchybar -m --set cpu_label label="${CPU_PERCENT}%" --set cpu_icon background.color="$BG_COLOR"
