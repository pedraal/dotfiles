#!/bin/sh

source ./colors.sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""
  ;;
  [6-8][0-9]) ICON=""
  ;;
  [3-5][0-9]) ICON=""
  ;;
  [1-2][0-9]) ICON=""
  ;;
  *) ICON=""
esac

case "${PERCENTAGE}" in
  [6-9][0-9]|100) COLOR="$green"
  ;;
  [3-5][0-9]) COLOR="$peach"
  ;;
  *) COLOR="$red"
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

sketchybar --set battery_label label="${PERCENTAGE}%"
sketchybar --set battery_icon icon="$ICON" background.color="$COLOR"
