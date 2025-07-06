#!/bin/bash

# get git repository root
root=$(git rev-parse --show-toplevel)

script="$root/scripts/json-formatter.py"
source="$root/profiles/desktop/.config/tridactyl.json"
target=$source

python "$script" "$source" "$target"
