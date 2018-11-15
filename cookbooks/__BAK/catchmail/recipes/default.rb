
['build-essential','libsqlite3-dev','ruby-dev'].each do |packageName|
    # Install the package
        package packageName do
        action :install
    end
end

gem_package 'mailcatcher' do
    action :install
end

template '/etc/systemd/system/mailcatcher.service' do
    source 'mailcatcher.init.systemd.conf.erb'
    mode 0644
    notifies :restart, 'service[mailcatcher]', :immediately
end

service 'mailcatcher' do
    supports restart: true
    action [:enable, :start]
end


# set the sendmail php fpm path
# template "Installing the php-sendmail-settings.ini in #{node['php']['default']['fpm-conf']}" do
#   path "#{node['php']['default']['fpm-conf']}/php-sendmail-settings.ini"
#   source 'php-sendmail-settings.ini.erb'
# end

# # set the sendmail php cli path
# template "Installing the php-sendmail-settings.ini in #{node['php']['default']['cli-conf']}" do
#   path "#{node['php']['default']['cli-conf']}/php-sendmail-settings.ini"
#   source 'php-sendmail-settings.ini.erb'
# end

# # set the sendmail path in php apache config
# template "Installing the php-sendmail-settings.ini for apache" do
#   path "/etc/php/#{node['php']['default']['version']}/apache2/conf.d/php-sendmail-settings.ini"
#   source 'php-sendmail-settings.ini.erb'
# end

# php_version = node['php']['default']['version']
# service "php#{php_version}-fpm" do
#   action [:start, :restart]
# end