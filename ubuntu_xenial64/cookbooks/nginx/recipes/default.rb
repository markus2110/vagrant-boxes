#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

package 'Install Nginx WebServer' do
  action :install
  package_name 'nginx'
end

service 'nginx' do
  supports status: false
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end
