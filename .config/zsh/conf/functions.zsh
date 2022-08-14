watch_file() {
  clear
  inotifywait -m -e close_write $1 \
  | while read changed; do
      # echo $changed
    clear
    bat -p --paging=never  $1
  done
}
