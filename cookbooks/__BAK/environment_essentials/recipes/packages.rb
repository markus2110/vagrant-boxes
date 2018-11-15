#
# Cookbook:: environment_essentials
# Recipe:: packages
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Essential packages to installe
essentialPackages = node['environment_essentials']['packages']
essentialPackages.each do |packageName,serviceConfig|

    # Install the package
    package packageName do
        action :install
    end

    # start the service if declared as service
    if serviceConfig
        service packageName do
          supports status: serviceConfig[:supportsStatus]
          action serviceConfig[:action]
        end

        Chef::Log.info "#{packageName} service started !"
    end
end
