#
# Cookbook:: customSetup
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#node.default['mysql']['default']['config_dir'] = '/etc/mysql/conf.d'

#include_recipe 'nginx'
# Create User if not exist doesn't work on Mysql5.5
#include_recipe 'mysql'
