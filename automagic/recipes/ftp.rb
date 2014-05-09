# Cookbook Name:: automagic-base
# Recipe:: ftp
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

node.set['pure-ftpd']['backend'] = 'pam'

include_recipe 'pure-ftpd'

group "ftp" do
end

user "wordpress" do
  comment "Wordpress FTP User"
  # Does not work
  # supports :manage_home => true
  group "ftp"
  # mkpasswd -m sha-512 unsecurepassword
  password "$6$V3qcx57fhAyF6a$Mg3Fm7V8fneASVP.ehvAYD.WOrnc2xPvQa/rPeEibif3HiYZQVRgFmUtQ5Ad.d4ztYq7Ml3SL5UARjEEEEk.b."
end

# Because :manage_home does not work
directory '/home/wordpress' do
  action :create
  owner 'wordpress'
  group 'ftp'
end
