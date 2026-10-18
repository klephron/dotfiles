#!/usr/bin/env bash

# Format mimeapps config files

set -euo pipefail

root="$(git rev-parse --show-toplevel)"
profile=${1:-"linux-desktop"}

profile_dir="$root/profiles/${profile}"
source="${XDG_CONFIG_HOME}/mimeapps.list"
target="$profile_dir/.config/mimeapps.list"
tmp="/tmp/mimeapps.list"

format_conf=("python" "$root/scripts/base/format-conf.py")

# backup original file
cp "$target" "$tmp"

# move and create link to mimeapps.list in dotfiles
if mv -v "$source" "$target"; then
  ln -vsfn "$target" "$source"
fi

"${format_conf[@]}" "$target"

if command -v diff-so-fancy >/dev/null 2>&1; then
    diff -u --label '' --label '' "$tmp" "$target" | diff-so-fancy
else
    diff -u --label '' --label '' "$tmp" "$target"
fi

rm -f "$tmp"
