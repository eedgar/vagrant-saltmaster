# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.hostname = "saltmaster-dev"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.provider "vmware_workstation" do |v, override|
    override.vm.box = "centos-7_1"
  end

  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box = "centos-7_1"
  end

  config.vm.synced_folder "cache/pki/", "/etc/salt/pki/",
    owner: "root",
    group: "root",
    mount_options: ["dmode=755","fmode=664"]

  config.vm.synced_folder "cache/srv", "/srv",
    owner: "root",
    group: "root",
    mount_options: ["dmode=755","fmode=664"]

  config.vm.network "forwarded_port", guest: 4505, host: 4505
  config.vm.network "forwarded_port", guest: 4506, host: 4506
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # Provisioners
  config.vm.provision "shell", path: "saltmaster-bootstrap.sh"
  #config.vm.provision :salt do |salt|
  #    salt.run_highstate = true
  #    salt.no_minion = true
  #end
end
