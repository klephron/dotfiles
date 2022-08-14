watch_file() {
  clear
  echo `pwd`/$1
  inotifywait -m -e close_write $1 \
  | while read changed; do
      # echo $changed
    clear
    bat -p --paging=never  $1
  done
}
