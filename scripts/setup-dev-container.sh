#!/bin/bash

echo "export XDG_CONFIG_HOME=~/.config" >> ~/.profile
echo "export ZDOTDIR=/home/nikit/.config/zsh" >> ~/.profile
source ~/.profile
make install/dev-container
