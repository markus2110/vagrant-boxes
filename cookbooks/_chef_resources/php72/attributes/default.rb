case node['platform']
  when 'debian', 'ubuntu'

    default['php']['default']['version'] =    '7.2'

    # The PHP Default Packages
    default['php']['default']['packages'] = {

      :apcu       => "php#{default['php']['default']['version']}-apcu",
      :common     => "php#{default['php']['default']['version']}-common",
      :cli        => "php#{default['php']['default']['version']}-cli",
      :curl       => "php#{default['php']['default']['version']}-curl",
      :dev        => "php#{default['php']['default']['version']}-dev",
      :fpm        => "php#{default['php']['default']['version']}-fpm",
      :gd         => "php#{default['php']['default']['version']}-gd",
      :intl       => "php#{default['php']['default']['version']}-intl",
      :mbstring   => "php#{default['php']['default']['version']}-mbstring",
      :mcrypt     => "php#{default['php']['default']['version']}-mcrypt",
      :memcached  => "php#{default['php']['default']['version']}-memcached",
      :mysql      => "php#{default['php']['default']['version']}-mysql",
      :pgsql      => "php#{default['php']['default']['version']}-pgsql",
      :soap       => "php#{default['php']['default']['version']}-soap",
      :xml        => "php#{default['php']['default']['version']}-xml",
      :zip        => "php#{default['php']['default']['version']}-zip"
    }

    # Environment configuration
    # Path settings
    default['php']['default']['fpm-socked'] = "/var/run/php/php#{default['php']['default']['version']}-fpm.sock"
    default['php']['default']['fpm-conf'] = "/etc/php/#{default['php']['default']['version']}/fpm/conf.d"
    default['php']['default']['cli-conf'] = "/etc/php/#{default['php']['default']['version']}/cli/conf.d"


    default['php']['default']['packages'][:apcu]      = "php-apcu"
    default['php']['default']['packages'][:imagick]   = "php-imagick"
    default['php']['default']['packages'][:mcrypt]    = "php-mcrypt"
    default['php']['default']['packages'][:memcached] = "php-memcached"
    default['php']['default']['packages'][:xdebug]    = "php-xdebug"
    


  when 'redhat', 'centos', 'fedora'
    Chef::Log.info "#{node['platform']} currently not supported"
end


default['php']['default']['xdebug'] = {
    :remote_enable          => 1,
    :remote_handler         => "dbgp",
    :remote_host            => node['ipaddress'],
    :remote_port            => 9000
}
