default['automagic']['db']['user'] = 'wordpress'
default['automagic']['db']['pass'] = 'unsecurepassword'
default['automagic']['db']['host'] = 'localhost'
default['automagic']['db']['name'] = 'wordpressdb'

normal['mysql']['server_root_password']   = node['automagic']['db']['pass']
normal['mysql']['server_debian_password'] = node['automagic']['db']['pass']
normal['mysql']['server_repl_password']   = node['automagic']['db']['pass']
