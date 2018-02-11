#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

$php_packages = [
    'php',
    'php-fpm',
    'php-mysql',
    'php-common',
    'php-curl',
    'php-dev',
    'php-intl',
    'php-mbstring',
    'php-mcrypt',
    'php-gd',
    'php-xml',
    'php-zip',
    'php-memcached',
    'php-xdebug',
    'php-imagick'
]

for $pack in $php_packages do
    package $pack do
      action :install
    end
end


# Start php-fpm Service
service 'php7.0-fpm' do
  supports status: true
  action [:enable, :start]
end
