#!/bin/sh

case "$1" in
  "-s"|"--swappy")
    grim -g "$(slurp)" - | swappy -f -
  ;;
  *) grim -g "$(slurp)" - | wl-copy
  ;;
esac

