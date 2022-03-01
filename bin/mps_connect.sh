#!/bin/bash

export QTWEBENGINE_CHROMIUM_FLAGS="--no-sandbox"
SLEEP_TIME=60 aws_connect.sh &
source $HOME/.virtualenvs/openconnect/bin/activate && openconnect-sso --server vpn.motionpicturesolutions.com --user athanasios.christakidis@motionpicturesolutions.com
