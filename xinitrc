#!/bin/sh
#
# ~/.xinitrc
#
# Read by xinit and by its front-end startx. It is mainly used to execute
# desktop environments, window managers and other programs when starting the X
# server.

# Load resources
[[ -f ~/.Xresources ]] && xrdb -merge "${HOME}/.Xresources"

# Turn off beep
set b off

# Hide mouse pointer
unclutter &

# Set default Chinese input method
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

# Launch i3 window manager
exec i3
