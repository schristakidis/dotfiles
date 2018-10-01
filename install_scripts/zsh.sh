#!/bin/bash

username=`who am i | awk '{print $1}'`

source get_release.sh

if [[ $is_arch ]]; then
    pacman -Syu
    pacman -S zsh curl gawk
else
    apt-get update
    apt-get install zsh curl gawk
fi


sudo -u $username 'curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh'
