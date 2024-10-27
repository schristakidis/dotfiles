#!/bin/bash

cd /tmp
grim screen.png

# Delete existing image
rm screen-out.png

#Adds a blur and vignette
ffmpeg -i screen.png -vf "gblur=sigma=10, vignette=PI/5" -c:a copy screen-out.png

1password --lock
pidof hyprlock || hyprlock

