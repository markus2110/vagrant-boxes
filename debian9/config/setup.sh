#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

# Install nginx, Mysql, ect...
sudo apt-get install -y nginx mysql-server memcached curl nfs-kernel-server git

# Install PHP
sudo apt-get install -y php7.0 php7.0-fpm php7.0-mysql php7.0-common php7.0-curl php7.0-dev php7.0-intl php7.0-mbstring php7.0-mcrypt php7.0-gd php7.0-xml php7.0-zip php7.0-ldap php-memcached php-xdebug php-imagick

# Install Composer
echo "installing composer";
curl -sS https://getcomposer.org/installer | php;
mv composer.phar /usr/local/bin/composer;

# Install Nodejs
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo npm install -g grunt
