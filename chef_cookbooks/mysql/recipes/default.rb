#
# Cookbook:: mysql
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

package 'mysql-server' do
  action :install
end


service 'start the mysql service' do
  service_name 'mysql'
  supports :start => true, :stop => true, :restart => true, :reload => true, :status => true
  action [:enable, :start]
end

# Create Mysql Users
include_recipe 'mysql::createusers'

# Create Mysql Users
include_recipe 'mysql::schema-restore'
