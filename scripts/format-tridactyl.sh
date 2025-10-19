#!/usr/bin/env bash

set -euo pipefail

root="$(git rev-parse --show-toplevel)"
profile="desktop"

source="$root/profiles/$profile/.config/tridactyl.json"

format_json=(python "$root/scripts/base/format-json.py")

"${format_json[@]}" "$source"
