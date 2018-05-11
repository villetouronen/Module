#!/bin/bash
# Original by Tero Karvinen Copyright 2018 Tero Karvinen http://TeroKarvinen.com GPL 3
# Github: https://github.com/terokarvinen/sirotin/blob/master/run.sh

setxkbmap fi
sudo apt-get update
sudo apt-get -y install git salt-minion

echo 'master: localhost'|sudo tee /etc/salt/minion
git clone https://github.com/villetouronen/Module
cd Module/
bash highstate.sh
