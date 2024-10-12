#!/bin/bash

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
root_path=$parent_path/..

cd $root_path

. ./dev-container/.xdgenv

make install/dev-container

chsh -s $(which zsh) root

zsh
