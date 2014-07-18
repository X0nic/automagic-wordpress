default['automagic']['restore']['s3_bucket'] = 'automagic-wordpress'
default['automagic']['restore']['s3_path']   = 'backups/wordpressdb'

default['s3cmd']['secret_key'] = node['aws_secret_access_key']
default['s3cmd']['access_key'] = node['aws_access_key_id']
