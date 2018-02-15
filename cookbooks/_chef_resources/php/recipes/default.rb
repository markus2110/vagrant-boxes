#
# Cookbook:: php
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

php_version = node['php']['default']['version']

if node['php']['default']['packages']
    php_packages = node['php']['default']['packages']
else
    php_packages = [
        "php#{php_version}-fpm",
        "php#{php_version}-mysql",
        "php#{php_version}-common",
        "php#{php_version}-curl",
        "php#{php_version}-dev",
        "php#{php_version}-intl",
        "php#{php_version}-mbstring",
        "php#{php_version}-mcrypt",
        "php#{php_version}-gd",
        "php#{php_version}-xml",
        "php#{php_version}-zip",
        "php#{php_version}-soap",

        "php-memcached",
        "php-imagick",
        "php-xdebug",

        "php#{php_version}-cli",
    ]
end


package 'Install PHP Packages' do
  action :install
  package_name php_packages
end


template "Installing the xdebug-settings.ini in #{node['php']['default']['fpm-conf']}" do
  path "#{node['php']['default']['fpm-conf']}/xdebug-settings.ini"
  source 'xdebug-settings.ini.erb'
end

template "Installing the php-dev-settings.ini in #{node['php']['default']['fpm-conf']}" do
  path "#{node['php']['default']['fpm-conf']}/php-dev-settings.ini"
  source 'php-dev-settings.ini.erb'
end


# Start php#{php_version}-fpm Service
service "php#{php_version}-fpm" do
  supports status: true
  action [:enable, :start, :restart]
end



script "Install Composer" do
  interpreter 'bash'
  user 'root'
  code <<-EOF
    curl -sS https://getcomposer.org/installer | php;
    mv composer.phar /usr/local/bin/composer;
    composer --version
  EOF
end

script "Install NodeJs" do
  interpreter 'bash'
  user 'root'
  code <<-EOF
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo npm install -g grunt
  EOF
end

# Install Nodejs
