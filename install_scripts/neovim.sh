#!/bin/bash

# Installs or updates NeoVim

source get_release.sh

if [[ $is_arch ]]; then
    sudo pacman -Syu
    sudo pacman -S neovim
else
    git clone https://github.com/neovim/neovim.git /tmp/neovim
    cd /tmp/neovim 
    version=$(git describe --abbrev=0)
    url="https://github.com/neovim/neovim/releases/download/$version/nvim.appimage"
    mkdir -p $HOME/bin
    rm -rf $HOME/bin/nvim
    curl -L $url -o $HOME/bin/nvim
    chmod +x $HOME/bin/nvim
    rm -rf /tmp/neovim
fi
