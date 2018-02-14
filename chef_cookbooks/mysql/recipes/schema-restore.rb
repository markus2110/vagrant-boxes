#
# Cookbook:: mysql
# Recipe:: schema-restore
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Create tmp sql dump directory
directory '/tmp/sql_dumps' do
  mode '0755'
  recursive true
  action :create
end

# Copy the sql dumps
cookbook_file "copy sql dumps" do
  source 'sql_dumps/test_db.sql'
  path '/tmp/sql_dumps/test_db.sql'
  mode '0755'
  action :create
end

script "Import Dump" do
  interpreter 'bash'
  user 'root'
  #cwd '/tmp'
  code <<-EOF
    sudo mysql --user=root --comments < /tmp/sql_dumps/test_db.sql
  EOF
end
