#
# Cookbook Name:: automagic-base
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'git'
include_recipe 'build-essential'
include_recipe 'vim'
# include_recipe 'user'
# include_recipe 'sudo'
include_recipe 'brightbox-ruby'
