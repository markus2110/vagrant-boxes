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
        "php#{php_version}",
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

        "php-memcached",
        "php-imagick",
        "php-xdebug"
    ]
end


package 'Install PHP Packages' do
  action :install
  package_name php_packages
end


# Start php#{php_version}-fpm Service
service "php#{php_version}-fpm" do
  supports status: true
  action [:enable, :start]
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
