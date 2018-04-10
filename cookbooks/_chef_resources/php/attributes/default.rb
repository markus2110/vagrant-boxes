case node['platform']
  when 'debian', 'ubuntu'

    # Set the PHP Version
    if node['platform'] == 'debian' && Gem::Version.new(node['platform_version']) < Gem::Version.new(9)
      Chef::Log.info "#{node['platform']} installing PHP5 packages"
      default['php']['default']['version'] =    '5'
    else
      Chef::Log.info "#{node['platform']} installing PHP7 packages"
      default['php']['default']['version'] =    '7.0'
    end

    # The PHP Default Packages
    default['php']['default']['packages'] = {
      :fpm        => "php#{default['php']['default']['version']}-fpm",
      :cli        => "php#{default['php']['default']['version']}-cli",
      :mysql      => "php#{default['php']['default']['version']}-mysql",
      :common     => "php#{default['php']['default']['version']}-common",
      :curl       => "php#{default['php']['default']['version']}-curl",
      :dev        => "php#{default['php']['default']['version']}-dev",
      :intl       => "php#{default['php']['default']['version']}-intl",
      :mcrypt     => "php#{default['php']['default']['version']}-mcrypt",
      :gd         => "php#{default['php']['default']['version']}-gd",
      :memcached  => "php#{default['php']['default']['version']}-memcached",
    }

    # Environment configuration

    # Check for debian < 9 ( install PHP5 )
    if node['platform'] == 'debian' && Gem::Version.new(node['platform_version']) < Gem::Version.new(9)
      # Path settings
      default['php']['default']['fpm-socked'] = '/var/run/php5-fpm.sock'
      default['php']['default']['fpm-conf'] = '/etc/php5/fpm/conf.d'
      default['php']['default']['cli-conf'] = '/etc/php5/cli/conf.d'

      default['php']['default']['packages'][:imagick] = "php#{default['php']['default']['version']}-imagick"
      default['php']['default']['packages'][:xdebug]  = "php#{default['php']['default']['version']}-xdebug"
      default['php']['default']['packages'][:soap]    = "php-soap"

    # PHP 7 Settings
    else
      # Path settings
      default['php']['default']['fpm-socked'] = '/var/run/php/php7.0-fpm.sock'
      default['php']['default']['fpm-conf'] = '/etc/php/7.0/fpm/conf.d'
      default['php']['default']['cli-conf'] = '/etc/php/7.0/cli/conf.d'

      default['php']['default']['packages'][:mbstring]  = "php#{default['php']['default']['version']}-mbstring"
      default['php']['default']['packages'][:soap]      = "php#{default['php']['default']['version']}-soap"
      default['php']['default']['packages'][:xml]       = "php#{default['php']['default']['version']}-xml",
      default['php']['default']['packages'][:zip]       = "php#{default['php']['default']['version']}-zip",

      default['php']['default']['packages'][:memcached] = "php-memcached"
      default['php']['default']['packages'][:imagick]   = "php-imagick"
      default['php']['default']['packages'][:xdebug]    = "php-xdebug"

    end

  when 'redhat', 'centos', 'fedora'
    Chef::Log.info "#{node['platform']} currently not supported"
end


default['php']['default']['xdebug'] = {
    :remote_enable          => 1,
    :remote_handler         => "dbgp",
    :remote_host            => node['ipaddress'],
    :remote_port            => 9000
}
