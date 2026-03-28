#!/bin/bash

get_brightness() {
  brightnessctl -m | cut -d',' -f4 | tr -d '%'
}

PERCENTAGE=$(get_brightness)

case "$1" in
up)
  brightnessctl set +1%
  ;;
down)
  brightnessctl set 1%-
  ;;
*)
  echo "{\"text\": \"$PERCENTAGE%  \", \"tooltip\": \"Brightness: $PERCENTAGE%\", \"class\": \"brightness\"}"
  ;;
esac
