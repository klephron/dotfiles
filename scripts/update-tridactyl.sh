#!/usr/bin/env bash

# Format tridactyl config files

set -euo pipefail

root="$(git rev-parse --show-toplevel)"
profile=${1:-"linux-desktop"}

profile_dir="$root/profiles/${profile}"
source="$profile_dir/.config/_tridactyl.json"

format_json=(python "$root/scripts/base/format-json.py")

"${format_json[@]}" "$source"
