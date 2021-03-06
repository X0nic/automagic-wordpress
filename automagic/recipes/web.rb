# Cookbook Name:: automagic
# Recipe:: web
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

node.set['nginx']['default_site_enabled'] = false

include_recipe 'nginx'
include_recipe 'php-fpm'

php_packages = %w{ php5-cgi php5 php5-dev php5-cli php-pear php-apc php5-curl php5-gd php5-memcache php5-mysql php5-fpm}
php_packages.each do |pkg|
  package pkg do
    action :install
  end
end

wordpress_nginx_site node['fqdn'] do
  host node['domain']
  root node['automagic']['wordpress_home']
end
