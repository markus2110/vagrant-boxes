# Cookbook:: environment_essentials
# Recipe:: packages
#
# Copyright:: 2018, The Authors, All Rights Reserved.



# Essential packages to installe
essential_packages = node['environment_essentials']['packages']
essential_packages.each do |package_name,service_config|
  # Install the package
  package package_name do
    action :install
  end

  # start the service if declared as service
  if service_config
    service package_name do
      supports status: service_config[:supportsStatus]
      action service_config[:action]
    end

    Chef::Log.info "#{package_name} service started !"
  end
end