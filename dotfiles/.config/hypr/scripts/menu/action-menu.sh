#!/bin/sh

conf_file="$HOME/.config/tofi/"

actions_list="󰌾 Lock\n󰍃 Logout\n󰑓 Reboot\n Suspend\n Shutdown"

selected=$(echo -e "$actions_list" | tofi --config "$conf_file/action.cfg" | sed "s/^..//")

case $selected in
  "Lock") loginctl lock-session ;;
  "Logout") hyprctl dispatch exit ;;
  "Reboot") reboot ;;
  "Suspend") systemctl suspend ;;
  "Shutdown") shutdown now ;;
  *) exit 1 ;;
esac
