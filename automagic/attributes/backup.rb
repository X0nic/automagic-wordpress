default['aws']['access_key_id']     = ''
default['aws']['secret_access_key'] = ''
default['backup']['dependencies']   = [['fog', '1.4.0'], ['s3'], ['parallel', '0.5.12']]


default['automagic']['backup']['s3_bucket'] = 'automagic-wordpress'
default['automagic']['backup']['s3_path']   = "/wordpress-backup"
