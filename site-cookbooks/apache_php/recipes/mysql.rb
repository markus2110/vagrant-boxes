#
# Cookbook:: apache_php
# Recipe:: mysql
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mysql_instance = node['mysql']['instance_name']

mysql_service "#{mysql_instance}" do
  port '3306'
  version '5.7'
  initial_root_password 'password'
  action [:create, :start]
end


mysql_config "#{mysql_instance} - Bind-Address Config" do
  source 'mysql/mysqld_bind_address.cnf.erb'
  notifies :restart, "mysql_service[#{mysql_instance}]"
  action :create
end

mysql_config "#{mysql_instance} - SQL-Mode Config" do
  source 'mysql/mysqld_sql_mode.cnf.erb'
  notifies :restart, "mysql_service[#{mysql_instance}]"
  action :create
end