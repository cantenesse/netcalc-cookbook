# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.hostname = "netcalc-berkshelf"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "opscode_ubuntu-13.10_chef-provisionerless"

  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-13.10_chef-provisionerless.box"

  config.vm.network :private_network, ip: "33.33.33.10"

  config.ssh.max_tries = 40
  config.ssh.timeout   = 120

  config.berkshelf.enabled = true


  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
        "recipe[netcalc::default]"
    ]
  end
end
