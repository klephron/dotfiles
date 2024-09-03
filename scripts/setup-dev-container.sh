#!/bin/bash

XDG_CONFIG_HOME=$HOME/.config make install/dev-container

chsh -s $(which zsh) root

zsh
