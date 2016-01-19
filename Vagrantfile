# -*- mode: ruby -*-
# vi: set ft=ruby :

branch = `git rev-parse --abbrev-ref HEAD`

boxes = [
    {
        :name => "ipa1.lab.edgar.loc",
        :eth1 => "192.168.242.10",
        :mem => "1024",
        :cpu => "1",
        :role => "ipa_server",
        :box => "rocketman110us/centos71-saltminion"
    },
    {
        :name => "ipa2.lab.edgar.loc",
        :eth1 => "192.168.242.11",
        :mem => "1024",
        :cpu => "2",
        :role => "ipa_server",
        :box => "rocketman110us/centos71-saltminion"
    },
    {
        :name => "ipac.lab.edgar.loc",
        :eth1 => "192.168.242.12",
        :mem => "1024",
        :cpu => "2",
        :role => "ipa_client",
        :box => "rocketman110us/centos71-saltminion"
    }
]

Vagrant.configure(2) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.hostname = "saltmaster-dev.lab.edgar.loc"
  config.vm.box = "rocketman110us/centos71"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  config.vm.provider "vmware_workstation" do |v, override|
    v.linked_clone = true if Vagrant::VERSION =~ /^1.8/
  end

  config.vm.provider "vmware_fusion" do |v, override|
    v.linked_clone = true if Vagrant::VERSION =~ /^1.8/
  end

  config.vm.define :saltmaster do |saltmaster_config|
    config.vm.hostname = "saltmaster-dev"
    saltmaster_config.vm.box = "rocketman110us/centos71"
    saltmaster_config.vm.network "forwarded_port", guest: 4505, host: 4505
    saltmaster_config.vm.network "forwarded_port", guest: 4506, host: 4506
    saltmaster_config.vm.network "forwarded_port", guest: 8000, host: 8000

    saltmaster_config.vm.synced_folder "cache/pki/", "/etc/salt/pki/",
        owner: "root",
        group: "root",
        mount_options: ["dmode=755","fmode=664"]

    saltmaster_config.vm.synced_folder "cache/srv", "/srv",
        owner: "root",
        group: "root",
        mount_options: ["dmode=755","fmode=664"]

     saltmaster_config.vm.network "private_network", ip: "192.168.242.3"

     # Provisioners
     saltmaster_config.vm.provision "shell", path: "saltmaster-bootstrap.sh", args: "%s" % [branch]
  end

  # Clients
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.box = opts[:box]
      config.vm.hostname = opts[:name]

      # Turn off shared folders
      config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

      config.vm.provider "vmware_fusion" do |v|
        v.linked_clone = true if Vagrant::VERSION =~ /^1.8/
        v.vmx["memsize"] = opts[:mem]
        v.vmx["numvcpus"] = opts[:cpu]
      end

      config.vm.network :private_network, ip: opts[:eth1]

      config.vm.synced_folder "cache/pki/%s" % opts[:name] , "/etc/salt/pki/",
        owner: "root",
        group: "root",
        mount_options: ["dmode=755","fmode=664"]

      # Provisioners
      config.vm.provision "shell", path: "saltminion-bootstrap.sh", args: "%s %s %s" % [ opts[:name], opts[:role], branch]
   end
  end
end
