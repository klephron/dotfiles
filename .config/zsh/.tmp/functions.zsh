watch_file() {
  file=`pwd`/$1
  dir=`dirname $file`

  clear
  if [[ ! -f "$file" ]]; then
    echo "File '$file' does not exist. Waiting for creation..."
    inotifywait -e create,moved_to --include $1 --format "%w%f %e" -q -q $dir
    clear
  fi
  # inotifywait -m -e close_write,delete_self,move_self --format "%e" $1 | 
  # {
  #   while read changed; do
  #     echo $changed
  #     if [ $changed = MOVE_SELF ]; then
  #       # clear
  #       echo "File '$file' was moved."
  #       break
  #       # exit
  #     elif [ $changed = DELETE_SELF ]; then
  #       # clear
  #       echo "File '$file' was deleted."
  #       exit
  #     fi
  #     # clear
  #     # bat -p --paging=never $file
  #   done
  # }
  while read changed; do
    echo $changed
    if [ $changed = MOVE_SELF ]; then
      # clear
      # echo "File '$file' was moved."
      echo "File was moved."
      break
      # exit
    elif [ $changed = DELETE_SELF ]; then
      # clear
      # echo "File '$file' was deleted."
      echo "File was deleted."
      exit
    fi
    # clear
    # bat -p --paging=never $file
  done < <(inotifywait -m -e close_write,delete_self,move_self --format "%e" $1)
  echo "THERE"
}
