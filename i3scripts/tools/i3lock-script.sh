#!/bin/bash
notify-send 'RUNNING LOCKER'
scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
convert $HOME/Pictures/Lock-icon.png -scale 25% /tmp/lock-icon.png
convert /tmp/screen.png /tmp/lock-icon.png -gravity center -composite -matte /tmp/screen.png
i3lock -e -f -i /tmp/screen.png
sleep 60 && [ 4000 -lt "$(xssstate -i)" ] &&  pgrep -x i3lock && xset dpms force off
