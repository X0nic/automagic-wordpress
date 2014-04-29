node.set['nginx']['default_site_enabled'] = false

include_recipe 'nginx'
include_recipe 'php-fpm'

php_packages = %w{ php5-cgi php5 php5-dev php5-cli php-pear php-apc php5-curl php5-gd php5-memcache php5-mysql php5-fpm}
php_packages.each do |pkg|
  package pkg do
    action :install
  end
end

wordpress_nginx_site node['fqdn'] do
  host node['domain']
  root '/var/www/wordpress'
end
