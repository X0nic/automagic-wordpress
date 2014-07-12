default['automagic']['wordpress_parent_dir'] = '/var/www'
default['automagic']['wordpress_dir_name'] = 'wordpress'
default['automagic']['wordpress_dir'] = File.join(node['automagic']['wordpress_parent_dir'], node['automagic']['wordpress_dir_name'])
