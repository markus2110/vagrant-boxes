#APT Update

apt_update 'daily' do
    frequency 86_400
    action :periodic
end

apt_update 'update' do
    ignore_failure true
    action :update
end

# Upgrade 
#        apt-get dist-upgrade -y
#        apt-get upgrade -vagrant y

# script "Upgrade Server" do
#     interpreter 'bash'
#     user 'root'
#     code <<-EOF
#         apt-get autoremove -y
#         apt-get autoclean -y
#         apt-get update -y
#     EOF
# end

# Install some essential packages
%w(curl nfs-kernel-server git htop).each do |package_name|
  # Install the package
  package package_name do
    action :install
  end
end

# https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce

# Install Docker CE
include_recipe 'docker::docker_ce'
include_recipe 'docker::docker_compose'
