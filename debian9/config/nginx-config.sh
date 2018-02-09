#!/bin/bash

# Use Nginx configs
NGINX_FILE_PATH='/vagrant/nginxconf/*.*'

for f in $NGINX_FILE_PATH
do
        echo "Creating Nginx symling $f => /etc/nginx/sites-enablede/"
        sudo ln -sf $f /etc/nginx/sites-enabled/
done
