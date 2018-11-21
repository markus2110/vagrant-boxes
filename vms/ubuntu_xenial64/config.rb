require '../cookbooks/config.rb'


# overwrites the vagrant settings in ../cookbook/config.rb
$VAGRANTFILE_NETWORK_IP         = "192.168.33.33"

#$VM_MEMORY 	    = 2048
#$VM_CPUS		= 2

# VM Port forwarding
$VM_PORT_FORWARDING = [
    { :GUEST_PORT => 80, :HOST_PORT => "8080" }
]

# VM Sync Folders
$VM_SYNC_FOLDERS = [
    { :HOST_PATH => "~/_DEV_/www", :GUEST_PATH => "/vagrant_data", :TYPE => "nfs" }
]

# Overwrite / extend Chef attributes
$CHEF_ATTRIBUTES = {
    # Set XDEBUG Remote IP
    "php" => {
        "default" => {
            "xdebug" => {
                "remote_host" => $VAGRANTFILE_HOST_IP
            }
        }
    }
}
