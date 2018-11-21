#!/bin/bash

DEFAULT_VAGRANTFILE_BOX="ubuntu/xenial64"
DEFAULT_VAGRANTFILE_NETWORK_IP="192.168.33.10"
DEFAULT_VAGRANTFILE_HOST_IP="192.168.33.1"
DEFAULT_VAGRANTFILE_NETWORK_HOST_PORT="8080"
DEFAULT_VM_NAME="ubuntu_xenial64"
DEFAULT_VM_MEMORY="2048"
DEFAULT_VM_CPUS="1"

VMS_FOLDER="vms"
GLOBAL_CONFIG="../config.rb"
FOLDER_RESULT="FIRST";

function checkFolder() {
    if [ -d $1 ]; then
        echo "The Vagrant folder '$1' exists, please use a different name!"
        FOLDER_RESULT="EXISTS";
    else 
        FOLDER_RESULT="OK"
    fi    
} 

echo "Create a new Vagrant Box";
echo "-------------------------"

until [  $FOLDER_RESULT = "OK" ]; do
    echo "VM Name ($DEFAULT_VM_NAME)"
    read VM_NAME;
    if [ -z $VM_NAME ] 
    then
        VM_NAME=$DEFAULT_VM_NAME
    fi;
    checkFolder "$VMS_FOLDER/$VM_NAME"
done

echo "Vagrant Box ($DEFAULT_VAGRANTFILE_BOX):"
read VAGRANTFILE_BOX;
if [ -z $VAGRANTFILE_BOX ] 
then
    VAGRANTFILE_BOX=$DEFAULT_VAGRANTFILE_BOX
fi;

echo "Box IP ($DEFAULT_VAGRANTFILE_NETWORK_IP):"
read VAGRANTFILE_NETWORK_IP ;
if [ -z $VAGRANTFILE_NETWORK_IP ] 
then
    VAGRANTFILE_NETWORK_IP=$DEFAULT_VAGRANTFILE_NETWORK_IP
fi;

echo "HOST IP ($DEFAULT_VAGRANTFILE_HOST_IP):"
read VAGRANTFILE_HOST_IP;
if [ -z $VAGRANTFILE_HOST_IP ] 
then
    VAGRANTFILE_HOST_IP=$DEFAULT_VAGRANTFILE_HOST_IP
fi;

echo "Host Port ($DEFAULT_VAGRANTFILE_NETWORK_HOST_PORT)"
read VAGRANTFILE_NETWORK_HOST_PORT;
if [ -z $VAGRANTFILE_NETWORK_HOST_PORT ] 
then
    VAGRANTFILE_NETWORK_HOST_PORT=$DEFAULT_VAGRANTFILE_NETWORK_HOST_PORT
fi;



echo "VM Memory ($DEFAULT_VM_MEMORY)"
read VM_MEMORY;
if [ -z $VM_MEMORY ] 
then
    VM_MEMORY=$DEFAULT_VM_MEMORY
fi;

echo "VM CPUS ($DEFAULT_VM_CPUS)"
read VM_CPUS;
if [ -z $VM_CPUS ] 
then
    VM_CPUS=$DEFAULT_VM_CPUS
fi;

echo "Vagrant Box config:
---------------------------------------------------------
Vagrant Box :   $VAGRANTFILE_BOX
IP :            $VAGRANTFILE_NETWORK_IP
HOST IP :       $VAGRANTFILE_HOST_IP
HOST_PORT :     $VAGRANTFILE_NETWORK_HOST_PORT
VM Name :       $VM_NAME
Memory :        $VM_MEMORY
CPUs :          $VM_CPUS
---------------------------------------------------------

Generate the Box ? (y/n)"
read GENERATE;
if [ "$GENERATE" != "y" ] 
then
    exit;
fi;


# create the folder
VMS_PATH="$VMS_FOLDER/$VM_NAME"
mkdir $VMS_PATH;

echo "$VMS_PATH created!"

cd $VMS_PATH;

# create the config file
echo "require '$GLOBAL_CONFIG'

# overwrites the vagrant settings in $GLOBAL_CONFIG
#\$VAGRANTFILE_API_VERSION        = \"2\"
#\$VAGRANTFILE_SSH_AGENT_FORWARD  = true
#\$VAGRANTFILE_HOST_IP            = \"$VAGRANTFILE_HOST_IP\"
\$VAGRANTFILE_BOX                = \"$VAGRANTFILE_BOX\"
\$VAGRANTFILE_NETWORK_IP         = \"$VAGRANTFILE_NETWORK_IP\"

# VM Config
#\$VM_SHOW_GUI  = false
\$VM_NAME       = \"$VM_NAME\"
\$VM_MEMORY     = $VM_MEMORY
\$VM_CPUS       = $VM_CPUS

# VM Port forwarding
\$VM_PORT_FORWARDING = [
    { :GUEST_PORT => 80, :HOST_PORT => \"$VAGRANTFILE_NETWORK_HOST_PORT\" }
]

# VM Sync Folders
\$VM_SYNC_FOLDERS = [
    { :HOST_PATH => \"/var/www\", :GUEST_PATH => \"/vagrant_data\", :TYPE => \"nfs\" }
]

# Defined in '$GLOBAL_CONFIG'
# \$CHEF_COOKBOOKS     = [\"../cookbooks\"]

\$CHEF_RECIPES = [
    'recipe[nginx_php]'
]

\$CHEF_ATTRIBUTES = {
    # Set XDEBUG Remote IP
#    'php' => {
#        'default' => {
#            'xdebug' => {
#                'remote_host' => \$VAGRANTFILE_HOST_IP
#            }
#        }
#    },

#    'nginx' => {
#        'default' => {
#            'server_suffix' => \$VM_NAME
#        }
#    }    
}" >> "config.rb.dist"

# Copy dist file
cp config.rb.dist config.rb;


# create the Vagrant file
echo "# -*- mode: ruby -*-
# vi: set ft=ruby :
require './config.rb'

# All Vagrant configuration is done below. The '2' in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(\$VAGRANTFILE_API_VERSION) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = \$VAGRANTFILE_BOX

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing 'localhost:8080' will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  \$VM_PORT_FORWARDING.each do |portConfig|
    config.vm.network 'forwarded_port', guest: portConfig[:GUEST_PORT], host: portConfig[:HOST_PORT]
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network 'forwarded_port', guest: 80, host: 8080, host_ip: '127.0.0.1'

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network 'private_network', ip: \$VAGRANTFILE_NETWORK_IP

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network 'public_network'

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  \$VM_SYNC_FOLDERS.each do |syncConfig|
    config.vm.synced_folder syncConfig[:HOST_PATH], syncConfig[:GUEST_PATH], :type => syncConfig[:TYPE]
  end


  #f true, agent forwarding over SSH connections is enabled. Defaults to false.
  config.ssh.forward_agent = \$VAGRANTFILE_SSH_AGENT_FORWARD

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  config.vm.provider 'virtualbox' do |vb|
    # The display name at the GUI
    vb.name = \$VM_NAME
    # Display the VirtualBox GUI when booting the machine
    vb.gui = \$VM_SHOW_GUI
    # Customize the amount of memory on the VM:
    vb.memory = \$VM_MEMORY
    # Customize the amount of CPUS to use by the VM:
    vb.cpus = \$VM_CPUS

#    vb.linked_clone = true
  end

  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision 'chef_solo' do |chef|
    chef.cookbooks_path = \$CHEF_COOKBOOKS
    chef.run_list = \$CHEF_RECIPES
    chef.json = \$CHEF_ATTRIBUTES
  end
end
" >> "Vagrantfile"

echo "--------------------------------"
echo "Switch to $VMS_PATH"
echo "RUN: vagrant up"