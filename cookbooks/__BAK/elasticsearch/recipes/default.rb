#
# Cookbook:: elasticsearch
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


elasticsearch "elasticsearch #{node['elasticsearch']['version']}" do
    version "#{node['elasticsearch']['version']}"
end