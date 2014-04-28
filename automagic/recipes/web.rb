node.set['nginx']['default_site_enabled'] = false

include_recipe 'nginx'
include_recipe 'php-fpm'

wordpress_nginx_site node['fqdn'] do
  host node['domain']
  root '/var/www/wordpress'
end
