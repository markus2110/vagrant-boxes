
docker_compose_latest = node['docker']['compose']['version']

# 1. Run this command to download the latest version of Docker Compose:
script "Download latest Docker Compose relese" do
    interpreter 'bash'
    user 'root'
    code <<-EOF
        curl -L https://github.com/docker/compose/releases/download/#{docker_compose_latest}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
    EOF
end