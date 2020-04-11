#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch Polybar, using default config location ~/.config/polybar/config

MAIN_SCREEN="$_bspwm_first_screen" polybar main &
if [ -z $_bspwm_second_screen ] ; then
    echo "Single Screen"
else
    SECOND_SCREEN=$_bspwm_second_screen polybar second &
fi
