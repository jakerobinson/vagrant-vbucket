# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "centos64fusion"
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provision "puppet" do |puppet|
    puppet.module_path   = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "default.pp"
  end

end
