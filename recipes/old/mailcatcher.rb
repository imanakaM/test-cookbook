#
# Cookbook Name:: cookbook-devbox
# Recipe:: mailcatcher
#
# Copyright 2014, Photocreate Co.,Ltd.
#
# All rights reserved - Do Not Redistribute
#
directory "/etc/php.d/" do
  owner node['sites_resources']['user']
  group node['sites_resources']['group']
  mode "0755"
  action :create
end

include_recipe "MailCatcher"
include_recipe "MailCatcher::php"

template "/etc/init.d/mailcatcher" do
  source "mailcatcher.erb"
  mode 0755
  owner node['php']['apache_user']
  group node['php']['apache_group']
end

bash "chkconfig mailcatcher add" do
  not_if 'chkconfig --list mailcatcher'
  code <<-EOC
    chkconfig --add mailcatcher
  EOC
end

bash "chkconfig mailcatcher on" do
  code <<-EOC
    chkconfig mailcatcher on
  EOC
end

bash "chkconfig start" do
  code <<-EOC
    /etc/init.d/mailcatcher start
  EOC
end
