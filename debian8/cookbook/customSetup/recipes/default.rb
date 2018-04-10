#
# Cookbook:: customSetup
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
node.default['php']['default']['version'] =    '5'
node.default['php']['default']['fpm-socked'] = '/var/run/php5-fpm.sock'
node.default['php']['default']['fpm-conf'] = '/etc/php5/fpm/conf.d'
node.default['php']['default']['cli-conf'] = '/etc/php5/cli/conf.d'
node.default['php']['default']['packages'] = [
    "php#{node['php']['default']['version']}",
    "php#{node['php']['default']['version']}-fpm",
    "php#{node['php']['default']['version']}-mysql",
    "php#{node['php']['default']['version']}-common",
    "php#{node['php']['default']['version']}-curl",
    "php#{node['php']['default']['version']}-dev",
    "php#{node['php']['default']['version']}-intl",
    "php#{node['php']['default']['version']}-mcrypt",
    "php#{node['php']['default']['version']}-gd",
    "php#{node['php']['default']['version']}-memcached",
    "php#{node['php']['default']['version']}-imagick",
    "php#{node['php']['default']['version']}-xdebug"
    #    "php#{node['php']['default']['version']}-xml",
    #    "php#{node['php']['default']['version']}-zip",
]

node.default['mysql']['default']['config_dir'] = '/etc/mysql/conf.d'

include_recipe 'environment_essentials'
include_recipe 'php'
include_recipe 'nginx'
# Create User if not exist doesn't work on Mysql5.5
#include_recipe 'mysql'
