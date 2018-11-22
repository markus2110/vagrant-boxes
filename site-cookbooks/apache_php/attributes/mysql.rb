
default['mysql']['instance_name']     = '5.7'
default['mysql']['bind-address']      = '0.0.0.0'
default['mysql']['initial_root_password'] = 'password'
default['mysql']['schema_restore'] = false
default['mysql']['sql_mode']          = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION'
default['mysql']['dump_directories']  = ['/vagrant_data/sql_dumps']


default['mysql']['users'] = {
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