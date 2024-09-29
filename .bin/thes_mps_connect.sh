#!/bin/bash

export QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox"
# export OPENSSL_CONF=~/.dotfiles/resources/openssl_mps.cnf
source $HOME/.pyenv/versions/opensso/bin/activate && openconnect-sso --server minions.motionpicturesolutions.com --user athanasios.christakidis@motionpicturesolutions.com -- --mtu=1450 --base-mtu=1300 

