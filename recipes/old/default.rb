#
# Cookbook Name:: test-cookbook
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
#include_recipe "test-cookbook::chef-mailcatcher"
#include_recipe "chef-mailcatcher"
include_recipe "test-cookbook::mailcatcher"
