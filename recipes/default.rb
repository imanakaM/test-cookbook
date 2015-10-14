#
# Cookbook Name:: test-cookbook
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "test-cookbook::git"
include_recipe "test-cookbook::rbenv"
include_recipe "test-cookbook::chef-mailcatcher"
include_recipe "test-cookbook::httpd"
include_recipe "test-cookbook::iptables"
include_recipe "test-cookbook::php"
