#!/bin/sh

OS_TYPE=$(uname -s)
if [ "${OS_TYPE}" = 'Linux' ]; then
    if [ ! -x '/usr/bin/salt-call' ];
    then
        wget -O install_salt.sh https://bootstrap.saltstack.com
        sudo sh install_salt.sh -U -M -L -S -P git v2015.8.3
        rm install_salt.sh
    fi
elif [ "${OS_TYPE}" = 'FreeBSD' ]; then
    if [ ! -x '/usr/local/bin/salt' ]; then
        fetch -o /tmp/salt_bootstrap.sh http://bootstrap.saltstack.com
        chmod +x /tmp/salt_bootstrap.sh
        sudo sh install_salt.sh -U -M -L -S -P git v2015.8.3
        rm install_salt.sh
    fi
elif [ "${OS_TYPE}" = 'Darwin' ]; then
    # Firstly, we need brew
    command -v brew > /dev/null 2>&1
    if [ $? -ne 0 ];
    then
	echo "Installing homebrew ..."
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Secondly, SaltStack
    command -v salt-call > /dev/null 2>&1
    if [ $? -ne 0 ];
    then
	echo "Installing SaltStack ..."
	brew install saltstack
    fi
fi

salt-call --config-dir=/vagrant/salt/config/ --log-level=quiet grains.setval role saltmaster
salt-call --config-dir=/vagrant/salt/config/ --state-output=mixed --log-level=quiet state.highstate

service salt-minion restart
salt-call state.highstate

