#
# Cookbook:: apache_php
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Installs the enviroment essentials
include_recipe 'environment_essentials'

include_recipe 'apache_php::mysql'