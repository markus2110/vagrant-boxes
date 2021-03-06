resource_name :elasticsearch

#, name_property: true,
property :port, String, default: '9200'
property :version, String, default: '6.2.3'
property :download_path1, String, default: 'https://artifacts.elastic.co/downloads/elasticsearch/'
property :download_path2, String, default: 'https://download.elastic.co/elasticsearch/elasticsearch/'
property :download_dir, String, default: '/tmp/elasticsearch/downloads/'

property :es_data_path, String, default: '/var/lib/elasticsearch'
property :es_log_path, String, default: '/var/log/elasticsearch'



# The Default action
default_action :create

#################################
# Create Elastic search 
#################################
action :create do

    if Gem::Version.new(new_resource.version) < Gem::Version.new(5)
        DONWLOAD_LINK = new_resource.download_path2
    else
        DONWLOAD_LINK = new_resource.download_path1
    end


    case node['platform']
        when 'debian', 'ubuntu'
            if node['platform'] == 'debian' && Gem::Version.new(node['platform_version']) < Gem::Version.new(9)
                JAVA_JDK = "openjdk-7-jre";
            else
                JAVA_JDK = "openjdk-8-jre";
            end
        when 'redhat', 'centos', 'fedora'
            Chef::Log.info "#{node['platform']} currently not supported"
        end


    Chef::Log.info "install Elastic search (#{new_resource.version}) on PORT:#{new_resource.port}"
    Chef::Log.info "Download (#{DONWLOAD_LINK}elasticsearch-#{new_resource.version}.deb)"

    package 'Install OpenJDK' do
        action :install
        package_name JAVA_JDK
    end        

    # Create the download directory
    directory "#{new_resource.download_dir}" do
        user 'vagrant'
        group 'vagrant'
        mode '0755'
        action :create
        recursive true
    end
    Chef::Log.info "#{new_resource.download_dir} created"

    # Download the file
    script 'Download elasticsearch package' do
        user 'vagrant'
        group 'vagrant'
        interpreter 'bash'
        code <<-EOH
            wget --tries=2 --directory-prefix=#{new_resource.download_dir} #{DONWLOAD_LINK}elasticsearch-#{new_resource.version}.deb
            sha1sum #{new_resource.download_dir}elasticsearch-#{new_resource.version}.deb
            sudo dpkg -i #{new_resource.download_dir}elasticsearch-#{new_resource.version}.deb
        EOH
        not_if { ::File.exist?("#{new_resource.download_dir}elasticsearch-#{new_resource.version}.deb") }
    end

    # Add the elasticsearch config file
    template "/etc/elasticsearch/elasticsearch.yml" do
        user 'elasticsearch'
        group 'elasticsearch'
        source 'elasticsearch.yml.erb'

        variables(
            data_path: new_resource.es_data_path,
            log_path: new_resource.es_log_path,
            port: new_resource.port
        )        
    end

    # Add elasticsearch to startup
    # STARTUP = "sudo /bin/systemctl daemon-reload && sudo /bin/systemctl enable elasticsearch.service && sudo /bin/systemctl start elasticsearch.service"
    # script 'elasticsearch on startup' do    
    #     user 'vagrant'
    #     group 'vagrant'
    #     interpreter 'bash'
    #     code <<-EOH
    #         #{STARTUP}
    #     EOH
    # end

    service 'elasticsearch' do
        action [:enable, :start]
    end
end