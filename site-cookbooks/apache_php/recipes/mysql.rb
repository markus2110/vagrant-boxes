#
# Cookbook:: apache_php
# Recipe:: mysql
#
# Copyright:: 2018, The Authors, All Rights Reserved.

mysql_instance = node['mysql']['instance_name']
mysql_sock = "/var/run/mysql-#{node['mysql']['instance_name']}/mysqld.sock"

mysql_service "#{mysql_instance}" do
  port '3306'
  version '5.7'
  bind_address node['mysql']['bind-address']
  initial_root_password node['mysql']['initial_root_password']
  action [:create, :start]
end


mysql_config "mysqld_sql_mode.cnf" do
  instance mysql_instance
  source 'mysql/mysqld_sql_mode.cnf.erb'
  notifies :restart, "mysql_service[#{mysql_instance}]"
  action :create
end


# Remove all remote users
script "remove mysql remote users" do
  interpreter 'bash'
  user 'root'
  #cwd '/tmp'
  code <<-EOF
    echo "DELETE from mysql.user WHERE host='%'; FLUSH PRIVILEGES;" | /usr/bin/mysql -S #{mysql_sock} -u root --password=#{node['mysql']['initial_root_password']};
  EOF
end


node['mysql']['users'].each do |name,config|
  createCommand = "CREATE USER '#{name}'@'%' IDENTIFIED BY '#{config[:password]}';"
  if config[:root]
    grandCommand  = "GRANT #{config[:grand]} privileges ON *.* TO '#{name}'@'%' WITH GRANT OPTION;"
  else
    grandCommand  = "GRANT #{config[:grand]} privileges ON *.* TO '#{name}'@'%';"
  end
  flushPriv     = "FLUSH PRIVILEGES;"

  mysqlCommand = "#{createCommand} #{grandCommand} #{flushPriv}"

  script "create mysql user '#{name}'" do
    interpreter 'bash'
    user 'root'
    #cwd '/tmp'
    code <<-EOF
      echo "#{mysqlCommand}" | /usr/bin/mysql -S #{mysql_sock} -u root --password=#{node['mysql']['initial_root_password']};
    EOF
  end
end



# Restores Test DB 
Dir.glob("#{__dir__}/../files/mysql/sql_dumps/*.sql").each do |sqlDump|
  script "Import Dump from #{sqlDump}" do
    interpreter 'bash'
    user 'root'
    code <<-EOF
      echo "DUMP #{sqlDump}"
      /usr/bin/mysql -S #{mysql_sock} -u root --password=#{node['mysql']['initial_root_password']} --comments < #{sqlDump}
    EOF
  end  
end


# Restore all dumps from given directory list
if node['mysql']['schema_restore'] == true
  
  node['mysql']['dump_directories'].each do |dumpDir|
    Dir.glob("#{dumpDir}/*.sql").each do |sqlDump|
      script "Import Dump from #{sqlDump}" do
        interpreter 'bash'
        user 'root'
        code <<-EOF
          echo "DUMP #{sqlDump}"
          /usr/bin/mysql -S #{mysql_sock} -u root --password=#{node['mysql']['initial_root_password']} --comments < #{sqlDump}
        EOF
      end  
    end
  end
end


