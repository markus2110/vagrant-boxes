case node['platform']
  when 'debian', 'ubuntu'

    default['pgsql']['default']['packages'] = {
      :server => 'postgresql',
      :client => 'postgresql-client'
    }


    default['pgsql']['default']['remote_host']        = '192.168.33.1'
    default['pgsql']['default']['listen_addresses']   = '*'
    default['pgsql']['default']['service']            = 'postgresql'
    default['pgsql']['default']['config_path']        = '/etc/postgresql/9.5/main'


  when 'redhat', 'centos', 'fedora'
    Chef::Log.info "#{node['platform']} currently not supported"
end


default['pgsql']['default']['users'] = {
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
