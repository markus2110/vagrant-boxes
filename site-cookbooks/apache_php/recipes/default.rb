#
# Cookbook:: apache_php
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


include_recipe 'apache2::default'

apache_conf 'default-site' do
  enable true
end

mysql_service '5.7' do
  port '3306'
  version '5.7'
  initial_root_password 'change me'
  action [:create, :start]
end