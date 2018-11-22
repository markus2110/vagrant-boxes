#
# Cookbook:: apache_php
# Recipe:: mysql
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mysql_service '5.7' do
  port '3306'
  version '5.7'
  initial_root_password 'change me'
  action [:create, :start]
end