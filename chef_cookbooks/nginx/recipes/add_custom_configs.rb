#
# Cookbook:: nginx
# Recipe:: add_customer_configs.rb
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create tmp sql dump directory


Dir.glob("#{__dir__}/../files/custom_configs/*.conf").each do |nginxConfig|

  destFileName = "/etc/nginx/sites-available/#{File.basename(nginxConfig)}"

  # Copy the config file
  file "copy nginx config '#{nginxConfig}'" do
    mode '0755'
    action :create
    path destFileName
    content IO.read(nginxConfig)
  end

  # enable the config
  link "#{node['nginx']['default']['config_path']}sites-enabled/#{File.basename(nginxConfig)}" do
    to destFileName
    only_if "test -f #{destFileName}"
  end

end
