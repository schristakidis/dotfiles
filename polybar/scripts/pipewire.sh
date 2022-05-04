#!/usr/bin/env bash

function main() {
    # DEFAULT_SOURCE=$(pw-record --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: description="\(.*\)" prio=[[:digit:]]\+$/\1/p')
    # DEFAULT_SINK_ID=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*\([[:digit:]]\+\):.*$/\1/p')
    # DEFAULT_SINK=$(pw-play --list-targets | sed -n 's/^*[[:space:]]*[[:digit:]]\+: description="\(.*\)" prio=[[:digit:]]\+$/\1/p')
    VOLUME=$(pamixer --get-volume-human)
    VOLUME_2=$(pamixer --get-volume)
    MUTED="婢 Muted"
    SILENT=""
    LOUD=""
    NORMAL="墳"

    action=$1
    if [ "${action}" == "up" ]; then
        pamixer --increase 5 --allow-boost --set-limit 150
    elif [ "${action}" == "down" ]; then
        pamixer --decrease 5 --allow-boost --set-limit 150
    elif [ "${action}" == "mute" ]; then
        pamixer --toggle-mute
    elif [ "${VOLUME_2}" -gt 75 ]; then
        echo "${LOUD}  ${VOLUME}"
    elif [ "${VOLUME_2}" -gt 45 ]; then
        echo "${NORMAL}  ${VOLUME}"
    elif [ "${VOLUME_2}" -gt 0 ]; then
        echo "${SILENT}  ${VOLUME}"
    else
        echo "${MUTED}"
        # echo " ${DEFAULT_SOURCE} |  ${VOLUME} ${DEFAULT_SINK}"
    fi
}

main "$@"
