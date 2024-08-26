#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

# # set proper dpi
# sed -i -E s/^Xft.dpi:96/Xft.dpi:144/ ~/.Xresources

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# setup for multiple monitors (96:laptop / 144:dual)
is_dual=$(xrandr --listactivemonitors | grep 'DisplayPort-0')

if [[ $is_dual != "" ]]
then
  sed -i -E 's/^Xft.dpi:.*/Xft.dpi:144/' ~/.Xresources
  xrdb ~/.Xresources
  autorandr --load dual
else
  sed -i -E 's/^Xft.dpi:.*/Xft.dpi:96/' ~/.Xresources
  xrdb ~/.Xresources
  autorandr --load laptop
fi


# Network manager applet
nm-applet &

# Composition manager
picom &

# Greenclip
exec greenclip daemon &

# Awesome window manager
exec awesome

