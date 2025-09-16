#!/usr/bin/env bash

set -euo pipefail

root="$(git rev-parse --show-toplevel)"
source="${XDG_CONFIG_HOME}/mimeapps.list"
target="$root/profiles/desktop/.config/mimeapps.list"
script="$root/scripts/conf-formatter.py"
tmp="/tmp/mimeapps.list"

# create formatted temporary file
python "$script" "$target" "$tmp"

# move and create link to mimeapps.list in dotfiles
mv -v "$source" "$target"
ln -vsfn "$target" "$source"

python "$script" "$target"

if command -v diff-so-fancy >/dev/null 2>&1; then
    diff -u --label '' --label '' "$tmp" "$target" | diff-so-fancy
else
    diff -u --label '' --label '' "$tmp" "$target"
fi

rm -f "$tmp"
