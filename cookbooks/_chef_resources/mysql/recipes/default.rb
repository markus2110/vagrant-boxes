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
  subscribes :restart, "template[#{node['mysql']['default']['config_dir']}/mysqld_sql_mode.cnf]", :immediately
end


template "#{node['mysql']['default']['config_dir']}/mysqld_bind_address.cnf" do
  source 'mysqld_bind_address.cnf.erb'
  owner 'root'
  group 'root'
  mode '0744'
end


template "#{node['mysql']['default']['config_dir']}/mysqld_sql_mode.cnf" do
  source 'mysqld_sql_mode.cnf.erb'
  owner 'root'
  group 'root'
  mode '0744'
end


# Create Mysql Users
include_recipe 'mysql::createusers'

# Restore DB schema
if node['mysql']['default']['schema_restore'] == true
    include_recipe 'mysql::schema-restore'
end

# restart the nginx
service 'mysql' do
  action [:restart]
end
