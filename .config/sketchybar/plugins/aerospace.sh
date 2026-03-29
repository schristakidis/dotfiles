#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

echo "triggered $1 $2" >> /tmp/sk.log
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    echo "focused sid:$1 focused:$FOCUSED_WORKSPACE previous:$PREV_WORKSPACE $NAME $SENDER" >> /tmp/sk.log
  sketchybar --set $NAME background.color=0xff003547 label.shadow.drawing=on icon.shadow.drawing=on background.border_width=2

    apps=$(aerospace list-windows --workspace "$1" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    echo "apps: $apps" >> /tmp/sk.log

    sketchybar --set space.$1 drawing=on

    icon_strip=" "
    if [ "${apps}" != "" ]; then
      while read -r app; do
        icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
      done <<<"${apps}"
    else
      icon_strip=""
    fi
    sketchybar --set space.$1 label="$icon_strip"
else
    echo "not focused $1 $FOCUSED_WORKSPACE $NAME $SENDER" >> /tmp/sk.log
  sketchybar --set $NAME background.color=0x44FFFFFF label.shadow.drawing=off icon.shadow.drawing=off background.border_width=0
fi

echo "/n" >> /tmp/sk.log
