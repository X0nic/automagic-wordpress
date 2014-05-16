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

      s3.bucket            = 'automagic-wordpress'
      s3.region            = "us-east-1"
      s3.path              = "/wordpress-backup"

      s3.directories do |directory|
        directory.add "/var/www/wordpress"
      end
    end
  DEF

  schedule({
    :minute => 0,
    :hour   => 0
  })
end
