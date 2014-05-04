node.set['mysql']['server_root_password']   = 'unsecurepassword'
node.set['mysql']['server_debian_password'] = 'unsecurepassword'
node.set['mysql']['server_repl_password']   = 'unsecurepassword'

include_recipe 'mysql::client'
include_recipe 'mysql::server'
include_recipe 'mysql-chef_gem'

db = {
  'user' => 'wordpress',
  'pass' => 'eRoT0Kct2XW6CVktV5Ky',
  'host' => '127.0.0.1',
  'name' => 'wordpressdb'
}

mysql_connection_info = {
  :host     => 'localhost',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}

mysql_database db['name'] do
  connection  mysql_connection_info
  action      :create
end

mysql_database_user db['user'] do
  connection    mysql_connection_info
  password      db['pass']
  host          db['host']
  database_name db['name']
  action        :create
end

mysql_database_user db['user'] do
  connection    mysql_connection_info
  database_name db['name']
  privileges    [:all]
  action        :grant
end
