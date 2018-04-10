#
# Cookbook:: mysql
# Recipe:: createusers
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Remove all remote users
script "remove mysql remote users" do
  interpreter 'bash'
  user 'root'
  #cwd '/tmp'
  code <<-EOF
    echo "DELETE from mysql.user WHERE host='%'; FLUSH PRIVILEGES;" | /usr/bin/mysql -u root;
  EOF
end


node['mysql']['default']['users'].each do |name,config|
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
      echo "#{mysqlCommand}" | /usr/bin/mysql -u root;
    EOF
  end
end
