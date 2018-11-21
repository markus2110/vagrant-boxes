require '../cookbooks/config.rb'

# overwrites the vagrant settings in ../cookbook/config.rb
#$VAGRANTFILE_API_VERSION        = "2"
#$VAGRANTFILE_SSH_AGENT_FORWARD  = true
#$VAGRANTFILE_HOST_IP            = "192.168.33.1"
$VAGRANTFILE_BOX                = "debian/jessie64"
$VAGRANTFILE_NETWORK_IP         = "192.168.33.10"

# VM Config
#$VM_SHOW_GUI  = false
$VM_NAME       = "debian8"
$VM_MEMORY     = 2048
$VM_CPUS       = 2

# VM Port forwarding
$VM_PORT_FORWARDING = [
    { :GUEST_PORT => 80, :HOST_PORT => "8080" }
]

# VM Sync Folders
$VM_SYNC_FOLDERS = [
    { :HOST_PATH => "/var/www", :GUEST_PATH => "/vagrant_data", :TYPE => "nfs" }
]

# Defined in '../cookbooks/config.rb'
# $CHEF_COOKBOOKS     = ["../cookbooks"]

$CHEF_RECIPES = [
    'recipe[nginx_php]'
]

$CHEF_ATTRIBUTES = {
    # Set XDEBUG Remote IP
#    'php' => {
#        'default' => {
#            'xdebug' => {
#                'remote_host' => $VAGRANTFILE_HOST_IP
#            }
#        }
#    },

#    'nginx' => {
#        'default' => {
#            'server_suffix' => $VM_NAME
#        }
#    }    
}