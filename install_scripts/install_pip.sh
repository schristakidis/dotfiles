#!/bin/bash

username=`who am i | awk '{print $1}'`

source get_release.sh

if which pip > /dev/null ; then
    echo 'pip is allready installed'
    exit 0
fi

if [[ $is_arch ]]; then
    pacman -Syu
    pacman -S python-pip python2-pip
else
    apt-get update
    if apt-cache search python-pip > dev/null; then
        apt-get install python-pip
    else
        python get-pip.py
    fi
fi
