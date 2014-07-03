# Cookbook Name:: automagic
# Recipe:: database
# Author:: Nathan Lee (<nathan@globalphobia.com>)
#
# Copyright (C) 2014 Nathan Lee
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# node.set['mysql']['server_root_password']   = 'unsecurepassword'
# node.set['mysql']['server_debian_password'] = 'unsecurepassword'
# node.set['mysql']['server_repl_password']   = 'unsecurepassword'

include_recipe 'mysql::client'
include_recipe 'mysql::server'
include_recipe 'mysql-chef_gem'

db = node['automagic']['db']

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
