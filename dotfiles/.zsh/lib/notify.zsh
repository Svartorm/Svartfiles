function bgnotify_formatted {
  ## $1=exit_status, $2=command, $3=elapsed_time
  #FIXME

  # Humanly readable elapsed time
  local elapsed="$(( $3 % 60 ))s"
  (( $3 < 60 ))   || elapsed="$((( $3 % 3600) / 60 ))m $elapsed"
  (( $3 < 3600 )) || elapsed="$((  $3 / 3600 ))h $elapsed"

  [ $1 -eq 0 ] && title="Holy Smokes Batman" || title="Holy Graf Zeppelin"
  [ $1 -eq 0 ] && icon="$HOME/icons/success.png" || icon="$HOME/icons/fail.png"
  bgnotify "$title - took ${elapsed}" "$2" "$icon"
}
