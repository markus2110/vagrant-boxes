#
# Cookbook:: php
# Recipe:: nodejs
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Install Nodejs
script "Install NodeJs" do
  interpreter 'bash'
  user 'root'
  code <<-EOF
    curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo npm install -g grunt gulp
  EOF
end
