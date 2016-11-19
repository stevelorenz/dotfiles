#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

xrdb -load ~/.Xresources

# Turn off beep
set b off

# Auto hide cursor
unclutter &
