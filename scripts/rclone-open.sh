#!/usr/bin/env bash

set -euo pipefail

drives_path=$HOME/${XDG_PUBLICSHARE_DIR}
download_path=$HOME/${XDG_DOWNLOAD_DIR}/rclone

file=$1

drive=$(realpath -s --relative-to="$drives_path" "$file" | cut -d'/' -f1)
drive_file=$(realpath -s --relative-to="$drives_path/$drive" "$file")

mkdir -pv "$download_path"

file_name=$(basename "$drive_file")

rclone copy -P --stats 100ms "$drive:$drive_file" "$download_path/$file_name"

xdg-open "$download_path/$file_name"
