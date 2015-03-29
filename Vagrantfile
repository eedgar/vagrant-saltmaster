# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "hashicorp/precise64"
  config.vm.hostname = "saltmaster-dev"

  config.vm.synced_folder "pki/", "/etc/salt/pki/"
  config.vm.network "forwarded_port", guest: 4505, host: 4505
  config.vm.network "forwarded_port", guest: 4506, host: 4506

  config.vm.provision "shell", path: "http://enas.familyds.com/~eedgar/saltmaster-bootstrap.sh"
end
