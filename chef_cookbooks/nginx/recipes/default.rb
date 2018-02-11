#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.




package 'nginx' do
  action :install
end


# Remove existing directory
if Dir.exists?(node['nginx']['default']['document_root'])
    Chef::Log.info "Directory exitst, will remove '#{node['nginx']['default']['document_root']}' from node"
    directory node['nginx']['default']['document_root'] do
      action :delete
    end
end

# Create eh default document root
directory node['nginx']['default']['document_root'] do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  recursive true
  action :create
end

# create the nginx default 
template "#{node['nginx']['default']['document_root']}/index.html" do
  source 'index.html.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end
