#
# Cookbook:: nginx
# Recipe:: add_customer_configs.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Copy all ServerConfig files from VAGRANT sync folder
Dir.glob("/vagrant/nginx/*.conf").each do |nginxconfig|
  destFileName = "/etc/nginx/sites-available/#{File.basename(nginxconfig)}"
  # Copy the config file
  file "copy nginx config '#{nginxconfig}'" do
    mode '0755'
    action :create
    path destFileName
    content IO.read(nginxconfig)
  end

  # enable the config
  link "#{node['nginx']['default']['config_path']}sites-enabled/#{File.basename(nginxconfig)}" do
    to destFileName
    only_if "test -f #{destFileName}"
  end
end
