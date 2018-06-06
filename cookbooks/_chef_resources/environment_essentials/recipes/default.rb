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

# Update APT repository on Debian and Ubuntu platforms
apt_update 'daily' do
    frequency node['environment_essentials']['update']['frequency']
    action :periodic
end

include_recipe 'environment_essentials::packages'


#create a swap file
script "Create swap " do
  interpreter 'bash'
  user 'root'
  code <<-EOF
    sudo fallocate -l 2G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    sudo swapon -s
    free -m
  EOF
end
