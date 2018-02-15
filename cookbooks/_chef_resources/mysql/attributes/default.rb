default['mysql']['default']['sqldump_directory'] = 'files/sql_dumps/'
default['mysql']['default']['sqldump_copy_directory'] = '/tmp/sql_dumps/'
default['mysql']['default']['bind-address'] = '0.0.0.0'


if node['platform'] == 'debian' && Gem::Version.new(node['platform_version']) >= Gem::Version.new(9)
  default['mysql']['default']['config_dir'] = '/etc/mysql/mariadb.conf.d'
else
  default['mysql']['default']['config_dir'] = '/etc/mysql/mysql.conf.d'
end


default['mysql']['default']['users'] = {
  "root" => {
    :password   => 'password',
    :grand      => 'ALL',
    :root       => true
  },
  "user" => {
    :password   => 'password',
    :grand      => 'ALL',
    :root       => false
  },
  "webuser" => {
    :password   => 'password',
    :grand      => 'ALL',
    :root       => false
  }
}
