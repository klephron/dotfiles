# !/bin/bash
clear
inotifywait -m -e modify launch.json \
| while read changed; do
    # echo $changed
  clear
  bat --style plain launch.json
done
