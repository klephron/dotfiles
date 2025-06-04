#!/usr/bin/env zsh

# adding zsh autocompeting
if [[ $EUID != 0 ]]; then
    typeset -xT SUDO_PATH sudo_path
    typeset -U sudo_path
    sudo_path=({,/usr/local,/usr}/sbin(N-/))
    alias sudo="sudo env PATH=\"SUDO_PATH:$PATH\""
fi

emulate bash
. ~/.profile
emulate zsh


