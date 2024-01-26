#!/bin/bash

export QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox"
export OPENSSL_CONF=./openssl.cnf
source $HOME/.pyenv/versions/opensso/bin/activate && openconnect-sso --server vpn.motionpicturesolutions.com --user athanasios.christakidis@motionpicturesolutions.com
