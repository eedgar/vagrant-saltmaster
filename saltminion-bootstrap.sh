#!/bin/sh

mkdir -p /etc/salt
echo $1 > /etc/salt/minion_id
wget -O install_salt.sh https://bootstrap.saltstack.com
sudo sh install_salt.sh -U -A 192.168.242.3 -P git v2015.8.3
rm install_salt.sh
salt-call --log-level=quiet grains.setval role $2
service salt-minion restart
#salt-call --state-output=mixed --log-level=quiet state.highstate

