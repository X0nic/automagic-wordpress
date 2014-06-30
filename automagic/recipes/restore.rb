database_restore_download_s3_backup_file "#{Chef::Config[:file_cache_path]}/#{node['automagic']['db']}.tar" do
  aws_access_key_id node[:aws][:access_key_id]
  aws_secret_access_key node[:aws][:secret_access_key]
  s3_dir_path node[:database_restore][:s3_dir_path]
  s3_bucket node[:database_restore][:s3_bucket]
  database node[:database_restore][:database_name]
  action :create
end

database_restore_from_file "#{Chef::Config[:file_cache_path]}/#{node[:database_restore][:database_name]}.tar" do
  source "#{Chef::Config[:file_cache_path]}/#{node[:database_restore][:database_name]}.tar"
  database_name node[:database_restore][:database_name]
  database_backup_name node[:database_restore][:database_backup_name]
  extract_to Chef::Config[:file_cache_path]
  mysql_host 'localhost'
  mysql_username 'root'
  mysql_password node[:mysql][:server_root_password]
end
