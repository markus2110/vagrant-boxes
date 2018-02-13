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

# check is nginx default symlink is set ?
nginxDefaultConfig = '/etc/nginx/sites-available/default'
if File.exists?(nginxDefaultConfig)
  file nginxDefaultConfig do
    action :delete
  end
end

# Add the config template
template "/etc/nginx/sites-available/default.conf" do
  source 'default.conf.erb'
end

# check is nginx default symlink is set ?
nginxDefaultConfigSymlink = '/etc/nginx/sites-enabled/default'
link nginxDefaultConfigSymlink do
  action :delete
  only_if "test -L #{nginxDefaultConfigSymlink}"
end

link nginxDefaultConfigSymlink do
  to "/etc/nginx/sites-available/default.conf"
  link_type :symbolic
end

# restart the nginx
service 'nginx' do
  action :restart
end
