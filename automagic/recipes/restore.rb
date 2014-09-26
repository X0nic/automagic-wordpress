database_restore_download_s3_backup_file "#{Chef::Config[:file_cache_path]}/#{node[:automagic][:db][:name]}.tar" do
  aws_access_key_id node[:aws_access_key_id]
  aws_secret_access_key node[:aws_secret_access_key]
  s3_dir_path node[:automagic][:restore][:s3_path]
  s3_bucket node[:automagic][:restore][:s3_bucket]
  database node[:automagic][:db][:name]
  action :create
end

database_restore_from_file "#{Chef::Config[:file_cache_path]}/#{node[:automagic][:db][:name]}.tar" do
  source "#{Chef::Config[:file_cache_path]}/#{node[:automagic][:db][:name]}.tar"
  database_name node[:automagic][:db][:name]
  database_backup_name node[:automagic][:db][:name]
  extract_to Chef::Config[:file_cache_path]
  mysql_host node[:automagic][:db][:host]
  mysql_username node[:automagic][:db][:user]
  mysql_password node[:automagic][:db][:pass]
end

directory node['automagic']['wordpress_parent_dir'] do
  action :create
end

include_recipe 'hipsnip-s3cmd'

execute 's3cmd ls' do
  command "s3cmd ls s3://#{node[:automagic][:restore][:s3_bucket]}/wordpress-backup/#{node['automagic']['wordpress_dir_name']}
  action :run
end

file "#{node['automagic']['wordpress_parent_dir']}/sync.sh" do
  content "s3cmd get --recursive s3://#{node[:automagic][:restore][:s3_bucket]}/wordpress-backup/#{node['automagic']['wordpress_dir_name']} #{node['automagic']['wordpress_dir']}"
  action :create
  mode '755'
end
