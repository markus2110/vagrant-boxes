#
# Cookbook:: environment_essentials
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

#if node['platform'] == 'debian' && Gem::Version.new(node['platform_version']) <= Gem::Version.new(8)
#  Chef::Log.info "Environment Packages for : #{node['platform']}(8)"
#else
#  Chef::Log.info "Environment Packages for : #{node['platform']}(#{node['platform_version']})"
#end


include_recipe 'environment_essentials::apt_update'
include_recipe 'environment_essentials::packages'


