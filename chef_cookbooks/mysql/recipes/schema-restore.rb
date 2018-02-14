#
# Cookbook:: mysql
# Recipe:: schema-restore
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Create tmp sql dump directory
directory "#{node['mysql']['default']['sqldump_copy_directory']}" do
  mode '0755'
  recursive true
  action :create
end


Dir.glob("#{__dir__}/../#{node['mysql']['default']['sqldump_directory']}/*.sql").each do |sqlDump|

  destFileName = "#{node['mysql']['default']['sqldump_copy_directory']}#{File.basename(sqlDump)}"

  # Copy the sql dumps
  file "copy sql dumps '#{sqlDump}'" do
    mode '0755'
    action :create
    path destFileName
    content IO.read(sqlDump)
  end

  # import dump
  script "Import Dump from #{destFileName}" do
    interpreter 'bash'
    user 'root'
    code <<-EOF
      sudo mysql --user=root --comments < #{destFileName}
    EOF
  end
end

# Remove the dump directory
directory "#{node['mysql']['default']['sqldump_copy_directory']}" do
  recursive true
  action :delete
end
