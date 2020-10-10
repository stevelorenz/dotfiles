#!/usr/bin/env bash

reboot="(ucode|cryptsetup|linux|nvidia|mesa|systemd|wayland|xf86-video|xorg)"
if [[ $(which yay) =~ (yay) ]]; then
    updates=$(
        checkupdates
        yay -Qua
    )
else
    updates=$(checkupdates)
fi
echo "$updates"
if [[ $updates =~ $reboot ]]; then
    echo "Updating possibly requires system restart ..."
fi
