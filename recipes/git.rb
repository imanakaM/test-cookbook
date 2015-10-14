#
# Cookbook Name:: cookbook-devbox
# Recipe:: git
#
# Copyright 2015, Photocreate Co.,Ltd.
#
# All rights reserved - Do Not Redistribute
#
#include_recipe 'git'

package "git" do
    action :install
end

bash 'git config --sysytem' do
  code <<-EOC
    git config --system user.email "#{node['git']['email']}"
    git config --system user.name "#{node['git']['username']}"
  EOC
end
