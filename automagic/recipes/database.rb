node.set['mysql']['server_root_password']   = 'unsecurepassword'
node.set['mysql']['server_debian_password'] = 'unsecurepassword'
node.set['mysql']['server_repl_password']   = 'unsecurepassword'

include_recipe 'mysql::client'
include_recipe 'mysql::server'
