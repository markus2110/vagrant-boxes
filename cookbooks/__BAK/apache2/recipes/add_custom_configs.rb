#
# Cookbook:: apache2
# Recipe:: add_customer_configs.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Copy all Apache Config files from VAGRANT sync folder
Dir.glob("/vagrant/apache2/*.conf").each do |apacheconfig|
  destFileName = "#{node['apache2']['default']['config_path']}sites-available/#{File.basename(apacheconfig)}"
  # Copy the config file
  file "copy apche config '#{apacheconfig}'" do
    mode '0755'
    action :create
    path destFileName
    content IO.read(apacheconfig)
  end

  # enable the config
  link "#{node['apache2']['default']['config_path']}sites-enabled/#{File.basename(apacheconfig)}" do
    to destFileName
    only_if "test -f #{destFileName}"
  end
end
