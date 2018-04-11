resource_name :elasticsearch

property :port, String, name_property: true
property :version, String, default: '6.2.3'

default_action :create



action :create do
    ##{new_resource.instance_name} 
    Chef::Log.warn "install Elastic search (#{new_resource.version}) on PORT:#{new_resource.port}"
end

action :delete do
    Chef::Log.info "remove Elastic search"
end
