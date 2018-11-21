#
# Cookbook:: environment_essentials
# Recipe:: apt_update
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Update APT repository on Debian and Ubuntu platforms

apt_update 'daily' do
    frequency node['environment_essentials']['update']['frequency']
    action :periodic
end

apt_update 'update' do
    ignore_failure true
    action :update
end