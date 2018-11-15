#
# Cookbook:: php
# Recipe:: composer
#
# Copyright:: 2018, The Authors, All Rights Reserved.

script "Install Composer" do
  interpreter 'bash'
  user 'root'
  code <<-EOF
    curl -sS https://getcomposer.org/installer | php;
    mv composer.phar /usr/local/bin/composer;
    composer --version
  EOF
end
