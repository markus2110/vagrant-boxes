# Global Config File

$VAGRANTFILE_API_VERSION        = "2"
$VAGRANTFILE_BOX                = "ubuntu/xenial64"
$VAGRANTFILE_HOST_IP            = "192.168.33.1"
$VAGRANTFILE_NETWORK_IP         = "192.168.33.10"
$VAGRANTFILE_NETWORK_GUEST_PORT = 80
$VAGRANTFILE_NETWORK_HOST_PORT  = 8080
$VAGRANTFILE_SSH_AGENT_FORWARD  = true

$VM_NAME        = "ubuntu_xenial64"
$VM_SHOW_GUI    = false
$VM_MEMORY 	    = 1024
$VM_CPUS		= 1

$VM_SYNC_FOLDERS = [
    { :HOST_PATH => "/var/www", :GUEST_PATH => "/vagrant_data", :TYPE => "nfs" },
]
