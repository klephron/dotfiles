#!/usr/bin/env bash

set -euo pipefail

root="$(git rev-parse --show-toplevel)"
profile="desktop"

source="${XDG_CONFIG_HOME}/mimeapps.list"
target="$root/profiles/$profile/.config/mimeapps.list"
tmp="/tmp/mimeapps.list"

format_conf=("python" "$root/scripts/base/format-conf.py")

# create formatted temporary file
"${format_conf[@]}" "$target" "$tmp"

# move and create link to mimeapps.list in dotfiles
mv -v "$source" "$target"
ln -vsfn "$target" "$source"

"${format_conf[@]}" "$target"

if command -v diff-so-fancy >/dev/null 2>&1; then
    diff -u --label '' --label '' "$tmp" "$target" | diff-so-fancy
else
    diff -u --label '' --label '' "$tmp" "$target"
fi

rm -f "$tmp"
