# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/vagrant', type: 'nfs'

  # VirtualBox.
  # `vagrant up virtualbox --provider=virtualbox`
  config.vm.define "virtualbox" do |virtualbox|
    virtualbox.vm.hostname = "virtualbox-rhel7"
    virtualbox.vm.box = "file://builds/virtualbox-rhel7.box"
    virtualbox.vm.network :private_network, ip: "172.16.3.2"

    config.vm.provider :virtualbox do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 1
      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      v.customize ["modifyvm", :id, "--ioapic", "on"]
    end

    if Vagrant.has_plugin?('vagrant-registration')
      config.registration.manager = 'subscription_manager'
      config.registration.name = virtualbox.vm.hostname
      config.registration.username = ENV['rhsm_username']
    end

    config.vm.provision "shell", inline: "echo Hello, World"
  end

end
