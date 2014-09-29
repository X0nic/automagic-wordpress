# Cookbook Name:: automagic
# Recipe:: backup
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

[ "build-essential", "libxml2-dev", "libxslt1-dev", "libyaml-dev" ].each do |pkg|
  package pkg do
    action :nothing
  end.run_action(:install)
end

include_recipe 'backup'

db = node['automagic']['db']
backup_model db['name'] do
  description "Back up #{db['name']}"

  definition <<-DEF
    split_into_chunks_of 4000

    database MySQL do |db|
      db.name = '#{db['name']}'
      db.username = '#{db['user']}'
      db.password = '#{db['pass']}' # will be interpolated
    end

    compress_with Gzip

    store_with S3 do |s3|
      s3.access_key_id = '#{node['aws']['access_key_id']}'
      s3.secret_access_key = '#{node['aws']['secret_access_key']}'
      s3.bucket = 'automagic-wordpress'
    end

    sync_with Cloud::S3 do |s3|
      s3.access_key_id = '#{node['aws']['access_key_id']}'
      s3.secret_access_key = '#{node['aws']['secret_access_key']}'

      s3.bucket            = "#{node['automagic']['backup']['s3_bucket']}"
      s3.region            = "us-east-1"
      s3.path              =  "#{node['automagic']['backup']['s3_path']}"

      s3.directories do |directory|
        directory.add "#{node['automagic']['wordpress_dir']}"
      end
    end
  DEF

  schedule({
    :minute => 0,
    :hour   => 0
  })
end
