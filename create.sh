#!/bin/bash

echo "Create a new Vagrant Box";
echo "Box name:"
read VAGRANTFILE_BOX ;

echo "Box IP:"
read VAGRANTFILE_NETWORK_IP ;

echo "HOST IP:"
read VAGRANTFILE_HOST_IP;

echo "Host Port"
read VAGRANTFILE_NETWORK_HOST_PORT;

echo "VM Name"
read VM_NAME;

echo "VM Memory"
read VM_MEMORY;

echo "VM CPUS"
read VM_CPUS;


# create the folder
mkdir $VM_NAME;
cd $VM_NAME;

# create the config file
echo "require '../cookbooks/config.rb'
# overwrites the vagrant settings in ../cookbook/config.rb
\$VAGRANTFILE_BOX                = '$VAGRANTFILE_BOX'
\$VAGRANTFILE_NETWORK_IP         = '$VAGRANTFILE_NETWORK_IP'
\$VAGRANTFILE_NETWORK_HOST_PORT  = '$VAGRANTFILE_NETWORK_HOST_PORT'

\$VM_NAME    = '$VM_NAME'
\$VM_MEMORY  = $VM_MEMORY
\$VM_CPUS    = $VM_CPUS

# VM Sync Folders
\$VM_SYNC_FOLDERS = [

]

\$CHEF_ATTRIBUTES = {
    # Set XDEBUG Remote IP
    'php' => {
        'default' => {
            'xdebug' => {
                'remote_host' => \$VAGRANTFILE_HOST_IP
            }
        }
    }
}" >> "config.rb"

# create the config.rb.dist file
echo "require '../cookbooks/config.rb'

# overwrites the vagrant settings in ../cookbook/config.rb
\$VAGRANTFILE_BOX                = '$VAGRANTFILE_BOX'
\$VAGRANTFILE_NETWORK_IP         = '$VAGRANTFILE_NETWORK_IP'
\$VAGRANTFILE_NETWORK_HOST_PORT  = '$VAGRANTFILE_NETWORK_HOST_PORT'

# VM Sync Folders
\$VM_SYNC_FOLDERS = [
    { :HOST_PATH => '/from/path1', :GUEST_PATH => '/to/path1', :TYPE => 'nfs' },
    { :HOST_PATH => '/from/path2', :GUEST_PATH => '/to/path2', :TYPE => 'nfs' },
    { :HOST_PATH => '/from/path3', :GUEST_PATH => '/to/path3', :TYPE => 'nfs' },
]

# Overwrite / extend Chef attributes 
\$CHEF_ATTRIBUTES = {
    # Set XDEBUG Remote IP
    'php' => {
        'default' => {
            'xdebug' => {
                'remote_host' => $VAGRANTFILE_HOST_IP
            }
        }
    }
}" >> "config.rb.dist"

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
  config.vm.network 'forwarded_port', guest: \$VAGRANTFILE_NETWORK_GUEST_PORT, host: \$VAGRANTFILE_NETWORK_HOST_PORT

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
    chef.cookbooks_path = '../cookbooks/_chef_resources'
    chef.run_list = [
        'recipe[environment_essentials]',
        'recipe[php]',
        'recipe[nginx]',
        'recipe[mysql]',
        'recipe[elasticsearch]'
    ]

    chef.json = \$CHEF_ATTRIBUTES
  end
end
" >> "Vagrantfile"