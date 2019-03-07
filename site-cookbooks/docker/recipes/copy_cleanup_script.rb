
# Copy the cleanup.sh script

cookbook_file "/home/vagrant/docker_cleanup.sh" do
  source 'docker_cleanup.sh'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end