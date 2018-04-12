#
# Cookbook:: mysql
# Recipe:: schema-restore
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Copy all SQL DUMPs from mysql->fiels->sql_dumps
# Create tmp sql dump directory
directory "#{node['mysql']['default']['sqldump_copy_directory']}" do
  mode '0755'
  recursive true
  action :create
end

# Copy all SQL files from mysql recipe
Dir.glob("#{__dir__}/../#{node['mysql']['default']['sqldump_directory']}/*.sql").each do |sqlDump|
  destFileName = "#{node['mysql']['default']['sqldump_copy_directory']}#{File.basename(sqlDump)}"
  # Copy the sql dumps
  file "copy sql dumps '#{sqlDump}'" do
    mode '0755'
    action :create
    path destFileName
    content IO.read(sqlDump)
  end
end

# Copy all SQL files from VAGRANT sync folder
Dir.glob("/vagrant/sql_dumps/*.sql").each do |sqlDump|
  destFileName = "#{node['mysql']['default']['sqldump_copy_directory']}#{File.basename(sqlDump)}"
  # Copy the sql dumps
  file "copy sql dumps '#{sqlDump}'" do
    mode '0755'
    action :create
    path destFileName
    content IO.read(sqlDump)
  end
end

# Restore Schema
Dir.glob("#{node['mysql']['default']['sqldump_copy_directory']}*.sql").each do |sqlDump|
   script "Import Dump from #{sqlDump}" do
     interpreter 'bash'
     user 'root'
     code <<-EOF
        echo "DUMP #{sqlDump}"
       sudo mysql --user=root --comments < #{sqlDump}
     EOF
   end
 end


# Remove the dump directory
directory "#{node['mysql']['default']['sqldump_copy_directory']}" do
  recursive true
  action :delete
end
