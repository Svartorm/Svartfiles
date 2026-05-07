#!/bin/sh

current="$(powerprofilesctl get)"

case $current in 
  "power-saver") powerprofilesctl set balanced ;;
  "balanced") powerprofilesctl set performance ;;
  "performance") powerprofilesctl set power-saver ;;
  *) echo "Error Wrong Power Mode" ;;
esac
