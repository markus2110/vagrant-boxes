#
# Cookbook:: php
# Recipe:: nodejs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install Nodejs
if (node['platform'] == 'debian' && Gem::Version.new(node['platform_version']) >= Gem::Version.new(8)) || (node['platform'] == 'ubuntu' ) 
  script "Install NodeJs #{node['platform_version']}" do
    interpreter 'bash'
    user 'root'
    code <<-EOF
      curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
      sudo apt-get install -y nodejs
      sudo npm install -g grunt gulp
    EOF
  end
end
