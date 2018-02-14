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
      recursive true
    end
end

# Create the default document root
directory node['nginx']['default']['document_root'] do
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
  recursive true
  action :create
end

# create the nginx default index
template "#{node['nginx']['default']['document_root']}/index.html" do
  source 'index.html.erb'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end

# Create the info page at the Nginx default doc root
template "#{node['nginx']['default']['document_root']}/phpinfo.php" do
  source 'phpinfo.php.erb'
  cookbook 'php'
  owner 'vagrant'
  group 'vagrant'
  mode '0755'
end


# check is nginx default symlink is set ?
nginxDefaultConfig = "#{node['nginx']['default']['config_path']}sites-available/#{node['nginx']['default']['config_name']}"
if File.exists?(nginxDefaultConfig)
  file nginxDefaultConfig do
    action :delete
  end
end

# check is nginx default symlink is set ?
nginxDefaultConfigSymlink = "#{node['nginx']['default']['config_path']}sites-enabled/#{node['nginx']['default']['config_name']}"
if File.exists?(nginxDefaultConfigSymlink)
  link nginxDefaultConfigSymlink do
    action :delete
  end
end

# Add the config template
template "#{node['nginx']['default']['config_path']}sites-available/default.conf" do
  source 'default.conf.erb'
end


link nginxDefaultConfigSymlink do
  to "#{node['nginx']['default']['config_path']}sites-available/default.conf"
  link_type :symbolic
end


include_recipe 'nginx::add_custom_configs'

# restart the nginx
service 'nginx' do
  action :reload
end
