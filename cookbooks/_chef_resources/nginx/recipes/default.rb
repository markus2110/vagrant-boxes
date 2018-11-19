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

# create the nginx default index
template "#{node['nginx']['default']['document_root']}/index.php" do
  source 'index.php.erb'
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


# Add the default config file
template "#{node['nginx']['default']['config_path']}sites-available/default.conf" do
  source 'default.conf.erb'
end
link "#{node['nginx']['default']['config_path']}sites-enabled/default" do
  to "#{node['nginx']['default']['config_path']}sites-available/default.conf"
  link_type :symbolic
end

# Add the project config file
# template "#{node['nginx']['default']['config_path']}sites-available/project.loc.conf" do
#   source 'project.loc.conf.erb'
# end
# link "#{node['nginx']['default']['config_path']}sites-enabled/project.loc.conf" do
#   to "#{node['nginx']['default']['config_path']}sites-available/project.loc.conf"
#   link_type :symbolic
# end

# Add the symfony project config file
template "#{node['nginx']['default']['config_path']}sites-available/symfony_project.sf.conf" do
  source 'symfony_project.sf.conf.erb'
end
link "#{node['nginx']['default']['config_path']}sites-enabled/symfony_project.sf.conf" do
  to "#{node['nginx']['default']['config_path']}sites-available/symfony_project.sf.conf"
  link_type :symbolic
end

# Add the test project config file
template "#{node['nginx']['default']['config_path']}sites-available/test.loc.conf" do
  source 'test.loc.conf.erb'
end
link "#{node['nginx']['default']['config_path']}sites-enabled/test.loc.conf" do
  to "#{node['nginx']['default']['config_path']}sites-available/test.loc.conf"
  link_type :symbolic
end


# Add SSL
include_recipe 'nginx::add_ssl_configs'
include_recipe 'nginx::add_custom_configs'

# restart the nginx
service 'nginx' do
  action :reload
end
