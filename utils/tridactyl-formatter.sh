#!/bin/bash

DIR=$(dirname "$0")

# execute only from git root
python $DIR/json-formatter.py .config/tridactyl.json .config/tridactyl.json
