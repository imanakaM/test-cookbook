#
# Cookbook Name:: mailcatcher
# Recipe:: default
#
# Copyright (C) 2015 SPINEN
#

# Install required dependencies
%w(
  gcc
  gcc-c++
  sqlite-devel
  ruby-devel
).each do |yum|
  package yum
end

execute "Install mailcatcher" do
 user "root"
 cwd "/tmp/"
 command "/usr/local/rbenv/shims/gem install mailcatcher --no-rdoc --no-ri --no-format-executable" 
  action :run
end

# Create init scripts for Mailcatcher daemon.
template '/etc/init.d/mailcatcher' do
  source 'mailcatcher.init.redhat.conf.erb'
  mode 0744
  notifies :restart, 'service[mailcatcher]', :immediately
end
service 'mailcatcher' do
  provider Chef::Provider::Service::Init
  supports start: true, stop: true, status: true
  action :start
end

execute "chkconfig mailcatcher on" do
 user "root"
 command "chkconfig mailcatcher on"
  action :run
end

