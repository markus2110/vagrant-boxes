#!/bin/bash

#http://www.daniloaz.com/en/how-to-create-a-user-in-mysql-mariadb-and-grant-permissions-on-a-specific-database/
#https://www.server-world.info/en/note?os=Debian_9&p=mariadb&f=1

ROOT_PASSWORD='password';
WEBUSER_PASSWORD='password';
MYSQL_CONFIG_FILE='/etc/mysql/mariadb.conf.d/50-server.cnf';

# Allow remote connections to mysql (don't do it like this in production)
sudo sed -i 's/bind-address		= 127.0.0.1/#bind-address		= 127.0.0.1/' ${MYSQL_CONFIG_FILE}


# Create Remote Admin
echo "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '${ROOT_PASSWORD}';GRANT ALL privileges ON *.* TO 'root'@'%' WITH GRANT OPTION;FLUSH PRIVILEGES;" | /usr/bin/mysql -u root;

# Create Default WebUser
echo "CREATE USER IF NOT EXISTS 'webuser'@'%' IDENTIFIED BY '${WEBUSER_PASSWORD}';GRANT USAGE ON *.* TO 'webuser'@'%' IDENTIFIED BY '${WEBUSER_PASSWORD}';GRANT ALL privileges ON *.* TO 'webuser'@'%';FLUSH PRIVILEGES;" | /usr/bin/mysql -u root;

# Display Users
echo "select user,host,password from mysql.user;" | /usr/bin/mysql -u root;

sudo service mysql restart

