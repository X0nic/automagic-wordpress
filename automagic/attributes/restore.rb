default['automagic']['restore']['s3_bucket'] = 'automagic-wordpress'
default['automagic']['restore']['s3_path']   = 'backups/wordpressdb'

default['s3cmd']['secret_key'] = node['aws']['secret_access_key']
default['s3cmd']['access_key'] = node['aws']['access_key_id']
