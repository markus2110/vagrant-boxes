require '../cookbooks/config.rb'

# overwrites the vagrant settings in ../cookbook/config.rb
#$VAGRANTFILE_BOX                = 'ubuntu/xenial64'
$VM_NAME                        = "ubuntu_xenial64_a2php72"
$VAGRANTFILE_NETWORK_IP         = '192.168.33.44'

# VM Port forwarding
$VM_PORT_FORWARDING = [
    { :GUEST_PORT => 80, :HOST_PORT => '8484' }   
]

# VM Sync Folders
$VM_SYNC_FOLDERS = [
    { :HOST_PATH => "/home/markus/_DEV_/www", :GUEST_PATH => "/vagrant_data", :TYPE => "nfs" }
]

# Overwrite / extend Chef attributes 
$CHEF_ATTRIBUTES = {
    # Set XDEBUG Remote IP
    'php' => {
        'default' => {
            'xdebug' => {
                'remote_host' => '192.168.33.1'
            }
        }
    },

    'apache2' => {
        'default' => {
            'server_suffix' => 'ubuntu-a2-php72'

        }
    }
}
