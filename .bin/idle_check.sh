#!/bin/bash

hyprctl clients -j | grep -i inhibitingidle | grep true > /dev/null
if [[ $? -eq 0 ]]; then
    echo " "
fi
