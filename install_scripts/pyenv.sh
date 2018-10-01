#!/bin/bash

username=`who am i | awk '{print $1}'`

source get_release.sh

if [[ $is_arch ]]; then
    pacman -Syu
    pacman -S sqlite bzip2 curl
else
    apt-get update
    apt-get install libbz2-dev libsqlite3-dev curl
fi

sudo -u $username 'curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash'

./install_pip.sh

pip install virtualenvwrapper
git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper
