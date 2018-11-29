# Uninstall old Docker versions
#Older versions of Docker were called docker or docker-engine. If these are installed, uninstall them:
%w(docker docker-engine docker.io).each do |package_name|
  # Install the package
  package package_name do
    action :remove
  end
end


# Install using the repository
# Before you install Docker CE for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.
# Set up the repository

# Install using the repository

# 1. Update the apt package index: Already done

# 2. Install packages to allow apt to use a repository over HTTPS:
%w(apt-transport-https ca-certificates curl software-properties-common).each do |package_name|
  # Install the package
  package package_name do
    action :install
  end
end


# 3. Add Docker’s official GPG key:
script "Docker GPG key" do
    interpreter 'bash'
    user 'root'
    code <<-EOF
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    EOF
end

# 4. Use the following command to set up the stable repository. 
# You always need the stable repository, even if you want to install builds from the edge or test repositories as well. 
# To add the edge or test repository, add the word edge or test (or both) after the word stable in the commands below.
apt_repository 'docker-repo' do
  uri 'https://download.docker.com/linux/ubuntu'
  components ['stable']
  distribution 'xenial'
  action :add
end


# Install Docker CE


# 1. Update the apt package index.
script "Update the apt package" do
    interpreter 'bash'
    user 'root'
    code <<-EOF
        apt-get update
    EOF
end

# 2. Install the latest version of Docker CE, or go to the next step to install a specific version
package "docker-ce" do
    action :install
end