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

  wordpress_home = '/var/www/wordpress'
  config.vm.synced_folder("wordpress", wordpress_home, :mount_options => ['dmode=777'])

  config.berkshelf.enabled = true
  config.vm.provision :chef_solo do |chef|
    # chef.cookbooks_path = ["cookbooks"]
    chef.provisioning_path = "/var/chef/cache" #set this, otherwise vagrant will delete chef cache on reboot
    chef.log_level = "debug"

    chef.add_recipe 'automagic-base'
    chef.add_recipe 'automagic'

    chef.json.merge!(
      "automagic" => {
        "wordpress_home" => wordpress_home
      },
      "mysql" => {
        "server_root_password" => 'GFMHP9mPcvL2tbDsQE1v', #set a default password for so it works with chef-solo
        "allow_remote_root"    => true
      },
      "wordpress" => {
        "version" => "3.9.1",
        "checksum" => "e69acc6b6fdbffc166fd96f2264d578b4944ef3e451eb9650e8ca795b665eeb0",
        "db" => {
          "database" => "wordpress",
          "user"     => "wordpress",
          "password" => "wordpress"
        }
      },
      :aws => {
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
        :access_key_id => ENV['AWS_ACCESS_KEY_ID']
      },
      :apt => {
        :compile_time_update => true
      }
      )
    end

  config.vm.provision :hostmanager

end
