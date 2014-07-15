# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.omnibus.chef_version = :latest
  config.vm.box = "opscode-ubuntu-12.04"
  config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.network :private_network, :ip => "33.33.33.10"
  config.vm.host_name = 'local.automagic.com'

  config.vm.provider "virtualbox" do |v|
    v.customize [ 'modifyvm', :id, '--memory', '1024' ]
    v.customize [ 'modifyvm', :id, '--cpus',   '2' ]
    v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
  config.vm.provision :hostmanager

end
