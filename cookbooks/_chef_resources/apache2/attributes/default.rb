majorVersionNumber, *rest = node['platform_version'].split(/\./)

default['apache2']['default']['document_root'] =              "/var/www/html"
default['apache2']['default']['project_root'] =               "/vagrant_data"
default['apache2']['default']['document_root_autoindex'] =    "on"
default['apache2']['default']['config_path'] =                "/etc/apache2/"
default['apache2']['default']['ssl_path'] =                   "/etc/apache2/ssl/"
default['apache2']['default']['server_suffix'] =              "#{node['platform']}#{majorVersionNumber}"
