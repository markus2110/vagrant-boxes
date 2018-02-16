default['mysql']['default']['sqldump_directory'] = 'files/sql_dumps/'
default['mysql']['default']['sqldump_copy_directory'] = '/tmp/sql_dumps/'
default['mysql']['default']['bind-address'] = '0.0.0.0'
default['mysql']['default']['sql_mode'] = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'




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
