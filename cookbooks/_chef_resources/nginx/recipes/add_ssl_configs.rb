#
# Cookbook:: nginx
# Recipe:: add_ssl_configs.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create SSL Folder
directory "#{node['nginx']['default']['ssl_path']}" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Copy the server.crt
cookbook_file "#{node['nginx']['default']['ssl_path']}server.crt" do
  source 'ssl/server.crt'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Copy the server.csr
cookbook_file "#{node['nginx']['default']['ssl_path']}server.csr" do
  source 'ssl/server.csr'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Copy the server.key
cookbook_file "#{node['nginx']['default']['ssl_path']}server.key" do
  source 'ssl/server.key'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Copy the server.key.org
cookbook_file "#{node['nginx']['default']['ssl_path']}server.key.org" do
  source 'ssl/server.key.org'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end
