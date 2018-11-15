#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

php_version = node['php']['default']['version']
php_packages = node['php']['default']['packages']


package 'Install PHP Packages' do
  action :install
  package_name php_packages.values
end


template "Installing the xdebug-settings.ini in #{node['php']['default']['fpm-conf']}" do
  path "#{node['php']['default']['fpm-conf']}/xdebug-settings.ini"
  source 'xdebug-settings.ini.erb'
end

template "Installing the php-dev-settings.ini in #{node['php']['default']['fpm-conf']}" do
  path "#{node['php']['default']['fpm-conf']}/php-dev-settings.ini"
  source 'php-dev-settings.ini.erb'
end

# remove the xdebug ini from cli
xdebugIniFile = "#{node['php']['default']['cli-conf']}/20-xdebug.ini"
link 'Removing xdebug.ini from php cli modules' do
  action :delete
  target_file xdebugIniFile
  only_if "test -f #{xdebugIniFile}"
end

# Start php#{php_version}-fpm Service
service "php#{php_version}-fpm" do
  supports status: true
  action [:enable, :start, :restart]
end

include_recipe 'php::composer'
include_recipe 'php::nodejs'
