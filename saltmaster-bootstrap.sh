#!/bin/sh

OS_TYPE=$(uname -s)
if [ "${OS_TYPE}" = 'Linux' ]; then
    if [ ! -x '/usr/bin/salt-master' ];
    then
        wget -O install_salt.sh https://bootstrap.saltstack.com
        sudo sh install_salt.sh -U -M -L -S -P git v2015.8.3
        rm install_salt.sh
    fi
elif [ "${OS_TYPE}" = 'FreeBSD' ]; then
    if [ ! -x '/usr/local/bin/salt-master' ]; then
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

salt-run fileserver.clear_cache backend=git
salt-run cache.clear_git_lock gitfs


# Switching to the installed config on the server and make sure it runs properly.
echo 'sleeping to let git caches build'
service salt-master restart
sleep 60

# Accept the salt key
salt-key -a `hostname` -y
echo "Setting saltmaster to be in the $1 environment"
salt-call --log-level=quiet grains.setval environment $1
salt-call --log-level=quiet grains.setval role saltmaster
salt-call --state-output=mixed --log-level=quiet state.highstate

