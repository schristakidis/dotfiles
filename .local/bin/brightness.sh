#!/usr/bin/env bash

get_backlight() {
    LIGHT=$((($(brightnessctl g)*100)/$(brightnessctl m)))
    echo "${LIGHT}%"
}
notify_user() {
    VALUE=$((($(brightnessctl g)*100)/$(brightnessctl m)))
    TEXT="Brightness "

    notify-send \
        --expire-time 800 \
        --hint string:x-canonical-private-synchronous:brightness \
        --hint "int:value:$VALUE" \
        --hint "int:transient:1" \
        "${TEXT}"
}

# Increase brightness
inc_backlight() {
	brightnessctl set 10%+ && notify_user
}

# Decrease brightness
dec_backlight() {
	brightnessctl set 10%- && notify_user
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	brightnessctl g
elif [[ "$1" == "--inc" ]]; then
	inc_backlight
elif [[ "$1" == "--dec" ]]; then
	dec_backlight
else
	get_backlight
fi
