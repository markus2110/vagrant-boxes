majorVersionNumber, *rest = node['platform_version'].split(/\./)

default['nginx']['default']['document_root'] =              '/vagrant_data'
default['nginx']['default']['document_root_autoindex'] =    'on'
default['nginx']['default']['config_path'] =                '/etc/nginx/'
default['nginx']['default']['server_suffix'] =              "#{node['platform']}#{majorVersionNumber}"
