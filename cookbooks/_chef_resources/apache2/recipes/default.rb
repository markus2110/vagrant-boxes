#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
package 'apache2' do
  action :install
end

package 'libapache2-mod-php7.2' do
  action :install
end



# Remove existing directory
if Dir.exists?(node['apache2']['default']['document_root'])
  Chef::Log.info "Directory exitst, will remove '#{node['apache2']['default']['document_root']}' from node"
  directory node['apache2']['default']['document_root'] do
    action :delete
    recursive true
  end
end

# Create the default document root
directory node['apache2']['default']['document_root'] do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  recursive true
  action :create
end

# create the default html index
template "#{node['apache2']['default']['document_root']}/index.html" do
  source 'index.html.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

# create the default php index
template "#{node['apache2']['default']['document_root']}/index.php" do
  source 'index.php.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

# Create the info page at the default doc root
template "#{node['apache2']['default']['document_root']}/phpinfo.php" do
  source 'phpinfo.php.erb'
  cookbook 'php72'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

# Add SSL
include_recipe 'apache2::add_vhost_configs'

# Add SSL
include_recipe 'apache2::add_ssl_configs'

# Install all custom config files
include_recipe 'apache2::add_custom_configs'

# restart the nginx
service 'apache2' do
  action :reload
end
