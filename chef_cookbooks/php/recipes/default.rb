#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

php_version = node['php']['default']['version']

php_packages = [
    "php#{php_version}",
    "php#{php_version}-fpm",
    "php#{php_version}-mysql",
    "php#{php_version}-common",
    "php#{php_version}-curl",
    "php#{php_version}-dev",
    "php#{php_version}-intl",
    "php#{php_version}-mbstring",
    "php#{php_version}-mcrypt",
    "php#{php_version}-gd",
    "php#{php_version}-xml",
    "php#{php_version}-zip",

    "php-memcached",
    "php-imagick",
    "php-xdebug"
]

for php_package in php_packages do
    package php_package do
      action :install
    end
end


# Start php#{php_version}-fpm Service
service "php#{php_version}-fpm" do
  supports status: true
  action [:enable, :start]
end
