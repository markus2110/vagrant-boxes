#
# Cookbook:: environment_essentials
# Recipe:: packages
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Essential packages to installe
essentialPackages = {
    # packageName => service configuration
    'htop'              => false,
    'git'               => false,
    'memcached'         => {
        supportsStatus: true,
        action: [:enable, :start]
    },
    'curl'              => false,
    'nfs-kernel-server' => false
}

essentialPackages.each do |packageName,serviceConfig|

    # Install the package
    package packageName do
        action :install
    end

    # start the service if declared as service
    if serviceConfig

        Chef::Log.info "Start #{packageName} service"

        service packageName do
          supports status: serviceConfig[:supportsStatus]
          action serviceConfig[:action]
        end
    end
end
