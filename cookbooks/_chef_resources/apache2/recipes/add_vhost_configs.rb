#
# Cookbook:: apache2
# Recipe:: add_vhost_configs.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Add the default config file
Chef::Log.info "Install default vhost config to : '#{node['apache2']['default']['config_path']}sites-available/'"
template "#{node['apache2']['default']['config_path']}sites-available/000-default.conf" do
  source 'default.conf.erb'
end
link "#{node['apache2']['default']['config_path']}sites-enabled/000-default.conf" do
  to "#{node['apache2']['default']['config_path']}sites-available/000-default.conf"
  link_type :symbolic
end


# Add the neos project config file
Chef::Log.info "Install neos vhost config to : '#{node['apache2']['default']['config_path']}sites-available/'"
template "#{node['apache2']['default']['config_path']}sites-available/100-neos_projects.conf" do
  source 'neos_projects.conf.erb'
end
link "#{node['apache2']['default']['config_path']}sites-enabled/100-neos_projects.conf" do
  to "#{node['apache2']['default']['config_path']}sites-available/100-neos_projects.conf"
  link_type :symbolic
end