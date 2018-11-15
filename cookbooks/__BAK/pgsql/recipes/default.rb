#
# Cookbook:: pgsql
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

pgsql_packages = node['pgsql']['default']['packages']
package 'Install PGSQL Packages' do
  action :install
  package_name pgsql_packages.values
end


template "Installing config file" do
  path "#{node['pgsql']['default']['config_path']}/postgresql.conf"
  source 'postgresql.conf.erb'

  variables(
    version: node['pgsql']['default']['version'],
    listenAddresses: node['pgsql']['default']['listen_addresses'],
    stats_temp_directory: "#{node['pgsql']['default']['version']}-main.pg_stat_tmp"
)     

end


template "Installing client auth file" do
  path "#{node['pgsql']['default']['config_path']}/pg_hba.conf"
  source 'client_auth.conf.erb'
end

# Start PGSQL Service
service "Start #{node['pgsql']['default']['service']} service" do
  supports status: true
  service_name node['pgsql']['default']['service']
  action [:enable, :start, :restart]
end


node['pgsql']['default']['users'].each do |name,config|
  script "create pgsql user '#{name}'" do
    interpreter 'bash'
    user 'root'
    code <<-EOF
      sudo -u postgres createuser #{name};
      echo "alter user #{name} with encrypted password '#{config[:password]}';" | sudo -u postgres psql;
      echo "ALTER ROLE #{name} SUPERUSER CREATEDB CREATEROLE INHERIT LOGIN; " | sudo -u postgres psql;
      echo "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO #{name};" | sudo -u postgres psql;
    EOF
  end
end


# Restore SQL Files from vagrant directory
#Dir.glob("/vagrant/sql_dumps/*.backup").each do |sqlDump|
#  script "Import Dump from #{sqlDump}" do
#    interpreter 'bash'
#    user 'root'
#    code <<-EOF
#      pg_restore -c --verbose --username=postgres --format=t --dbname=tuicatalog
#      pg_restore -d #{File.basename(sqlDump, ".backup")} #{sqlDump}
#    EOF
#  end  
#end