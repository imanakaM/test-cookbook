#
# Cookbook Name:: cookbook-devbox
# Recipe:: php
#
# Copyright 2015, Photocreate Co.,Ltd.
#
# All rights reserved - Do Not Redistribute
#

configure_options = node['php']['configure_options'].join(' ')
version = node['php']['version']

node["php"]["yum_packages"].each do |name|
  yum_package "install #{name}" do
    package_name name
    action :install
  end
end

cookbook_file "/tmp/icu4c-49_1_2-src.tgz" do
  mode 00644
  checksum "cce83cc88a2ff79d65c05426facbf30530bbe13a1cfda04b3ab81b55414cf5a3"
end

bash "install icu-config" do
  cwd '/tmp'
  not_if 'which icu-config '
  code <<-EOC
    tar zxfv icu4c-49_1_2-src.tgz
    cd icu/source
    ./configure CC=gcc
    make
    sudo make install
  EOC
end

cookbook_file "/tmp/php-#{node['php']['version']}.tar.gz" do
  mode 00644
  checksum node['php']['checksum']
end

if node['php']['ext_dir']
  directory node['php']['ext_dir'] do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
  end
  ext_dir_prefix = "EXTENSION_DIR=#{node['php']['ext_dir']}"
else
  ext_dir_prefix = ''
end

bash 'build php' do
  cwd '/tmp'
  code <<-EOF
  tar -zxf php-#{version}.tar.gz
  (cd php-#{version} && #{ext_dir_prefix} ./configure #{configure_options})
  (cd php-#{version} && make && make install)
  EOF
  not_if "which #{node['php']['bin']}"
end

bash "add php-extention bz2" do
  not_if { File.exists?("#{node['php']['ext_dir']}/bz2.so") }
  cwd "/tmp/php-#{version}/ext/bz2"
  code <<-EOC
    /usr/local/bin/phpize
    ./configure --with-php-config=/usr/local/bin/php-config
    make
    make install
  EOC
end

#directory node['php']['conf_dir'] do
#  owner 'root'
#  group 'root'
#  mode '0755'
#  recursive true
#end
#
#directory node['php']['ext_conf_dir'] do
#  owner 'root'
#  group 'root'
#  mode '0755'
#  recursive true
#end

#php_pear_channel 'pear.php.net' do
#  action :update
#end
#
#php_pear_channel 'pecl.php.net' do
#  action :update
#end
#
#node["php"]["pear_packages"].each do |name|
#  php_pear name do
#    action :install
#  end
#end

#if node["php"]["xdebug"]["is_enable"] == true
#  bash "pecl install xdebug" do
#    not_if "pecl list |grep xdebug"
#    code <<-EOC
#      pecl install xdebug
#    EOC
#    notifies :restart, "service[apache2]"
#  end
#else
#  bash "pecl uninstall xdebug" do
#    only_if "php -i |grep 'xdebug support => enabled'"
#    code <<-EOC
#      pecl uninstall xdebug
#    EOC
#    notifies :restart, "service[apache2]"
#  end
#end

#template "/etc/httpd/conf/httpd.conf" do
#  source "httpd.conf.erb"
#  mode 0755
#  owner node['php']['apache_user']
#  group node['php']['apache_group']
#end
#
#
template "/etc/httpd/conf/php.ini" do
  source "php.ini.erb"
  mode 0755
  owner "root"
  group "root"
#  notifies :restart, "service[apache2]"
end

#include_recipe "cookbook-devbox::sites_submodules"
