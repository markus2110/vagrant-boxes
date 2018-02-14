default['mysql']['default']['sqldump_directory'] = 'files/sql_dumps/'
default['mysql']['default']['sqldump_copy_directory'] = '/tmp/sql_dumps/'

default['mysql']['default']['users'] = {
  "root" => {
    :password   => 'password',
    :grand      => 'ALL',
    :root       => true
  },
  "webuser" => {
    :password   => 'password',
    :grand      => 'ALL',
    :root       => false
  }
}
