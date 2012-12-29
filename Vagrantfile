# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # config.vm.box = "lucid64"
  config.vm.box = "precise64"
  # config.vm.box_url = "http://files.vagrantup.com/lucid64.box"
  config.vm.box_url = "http://files.vagrantup.com/prescise64.box"
  config.vm.network :hostonly, "33.33.33.10"
  config.vm.forward_port 80, 8080
  config.vm.forward_port 81, 8081

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks"]
    chef.provisioning_path = "/var/chef/cache" #set this, otherwise vagrant will delete chef cache on reboot
    chef.log_level = "debug"

    chef.add_recipe "apt"
    chef.add_recipe "build-essential"
    chef.add_recipe "vim"
    # chef.add_recipe "user"
    # chef.add_recipe "sudo"
    # chef.add_recipe "rvm::vagrant"
    # chef.add_recipe "rvm::system"
    # chef.add_recipe "rbenv::vagrant"
    # chef.add_recipe "rbenv::system"
    chef.add_recipe "git"
    chef.add_recipe "wordpress"
    # chef.add_recipe "dmg"

    chef.json.merge!(
      "mysql" => {
        "server_root_password" => 'GFMHP9mPcvL2tbDsQE1v', #set a default password for so it works with chef-solo
        "allow_remote_root"    => true
      },

      "wordpress" => {
        "version" => "3.4.2",
        "checksum" => "e69acc6b6fdbffc166fd96f2264d578b4944ef3e451eb9650e8ca795b665eeb0",
        "db" => {
          "database" => "wordpress",
          "user"     => "wordpress",
          "password" => "wordpress"
        }
      }
    )
  end
end
