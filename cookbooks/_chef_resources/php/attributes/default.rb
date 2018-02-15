default['php']['default']['version'] =    '7.0'
default['php']['default']['fpm-socked'] = '/var/run/php/php7.0-fpm.sock'
default['php']['default']['fpm-conf'] = '/etc/php/7.0/fpm/conf.d'

default['php']['default']['xdebug'] = {
    :remote_enable          => 1,
    :remote_handler         => "dbgp",
    :remote_host            => "192.168.33.33",
    :remote_port            => 9000
}
