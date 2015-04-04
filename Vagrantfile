# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.hostname = "saltmaster-dev"

  config.vm.provider "vmware_workstation" do |v, override|
    override.vm.box = "chef/ubuntu-14.10"
  end

  config.vm.provider "vmware_fusion" do |v, override|
    override.vm.box = "chef/ubuntu-14.10"
  end

  config.vm.provider "docker" do |d|
    d.vagrant_vagrantfile = "../i7-formula/Vagrantfile"
      d.image  = "phusion/baseimage-1410-saltmaster"
      d.cmd    = ["/sbin/my_init", "--enable-insecure-key"]
      d.has_ssh = true
  end

  config.vm.provider "docker" do |v, override|
    override.ssh.username = "root"
    override.ssh.private_key_path = "key/phusion.key"
  end

  config.vm.synced_folder "pki/", "/etc/salt/pki/",
    owner: "root",
    group: "root",
    mount_options: ["dmode=755,fmode=664"]

  config.vm.synced_folder "salt_srv", "/srv",
    owner: "root",
    group: "root",
    mount_options: ["dmode=755,fmode=664"]

  config.vm.network "forwarded_port", guest: 4505, host: 4505
  config.vm.network "forwarded_port", guest: 4506, host: 4506
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # Provisioners
  config.vm.provision "shell", path: "saltmaster-bootstrap.sh"
  config.vm.provision :salt do |salt|
      salt.run_highstate = true
      salt.no_minion = true
  end
end
