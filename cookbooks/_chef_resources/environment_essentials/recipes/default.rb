#
# Cookbook:: environment_essentials
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Update APT repository on Debian and Ubuntu platforms
apt_update 'daily' do
    frequency 86_400
    action :periodic
end

include_recipe 'environment_essentials::packages'
