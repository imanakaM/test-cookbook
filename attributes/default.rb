#
# Cookbook Name:: mailcatcher
# Recipe:: default
#
# Copyright 2013, Bryan te Beek
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#### mailchatcher
default['mailcatcher']['bin'] = '/usr/bin/env catchmail'

#default['mailcatcher']['http-ip'] = '192.168.50.26'
#default['mailcatcher']['http-ip'] = '192.168.33.20'
host_address_val = node["network"]["interfaces"]["eth1"]["addresses"].select { |address_key, address_val| address_val["family"] == "inet" }
host_address_array = host_address_val.keys
default['mailcatcher']['http-ip'] = host_address_array[0]

default['mailcatcher']['http-port'] = 1080

#default['mailcatcher']['smtp-ip'] = '127.0.0.1'
default['mailcatcher']['smtp-ip'] = '127.0.0.1'
default['mailcatcher']['smtp-port'] = 1025

default['mailcatcher']['multiple'] = false

#### rbenv
default['rbenv']['ruby']['versions'] = [
    #"1.8.7-p352",
    "2.1.2"
]
default['rbenv']['ruby']["global"] = "2.1.2"

##### git
default['git']['email'] = 'dev@photocreate.co.jp'
default['git']['username'] = 'vagrant'

##### php
default['php']['version'] = '5.4.17'
default['php']['install_method'] = 'source'
default['php']['url'] = 'http://jp1.php.net/get'
default['php']['checksum'] = '7a334949a90534480719af7b15b918dd4162e5d3255fc98be5d95756a746589d'
default['php']['ext_dir'] = '/usr/local/lib/php/extensions'
default['php']['configure_options'] = [
    '--with-apxs2',
    '--with-config-file-path=/etc/httpd/conf',
    '--enable-exif',
    '--enable-mbstring',
    '--with-pgsql',
    '--with-xmlrpc',
    '--enable-zend-multibyte',
    '--with-gd',
    '--with-pear',
    '--with-curl',
    '--with-zlib',
    '--with-bz2',
    '--enable-mbregex',
    '--enable-ftp',
    '--with-jpeg-dir=/usr',
    '--with-openssl',
    '--enable-intl',
    '--with-bz2',
    '--with-freetype-dir=/usr/share/fonts/ja/TrueType'
]
default['php']['ini']['template'] = 'php.ini.erb'
default['php']['bin'] = 'php'
default['php']['yum_packages'] = [
    'make',
    'gcc',
    'gcc-c++',
    'postgresql-devel',
    'httpd-devel',
    'openssl-devel',
    'bzip2-devel',
    'libxml2-devel',
    'libcurl-devel',
    'libjpeg-devel',
    'libpng-devel',
    'libXpm-devel',
    'sendmail-devel',
    'freetype-devel',
    'unzip'
]
default['php']['pear_packages'] = [
    'Cache_Lite',
    'File_Archive'
]
default['php']['apache_user'] = 'vagrant'
default['php']['apache_group'] = 'vagrant'
default['php']['session.save_handler'] = 'user'
default['php']['sendmail_path'] = 'sendmail -t tdev@photocreate.co.jp -i'
default['php']['auto_prepend_file'] = '/data/sites/opt/sharedance/session_handler.php'
default['php']['memory_limit'] = '128M'
default['php']['max_execution_time'] = '30'
default['php']['opcache']['is_enable'] = true
default['php']['xdebug']['is_enable'] = true
default['php']['xdebug']['remote_enable'] = 1
default['php']['xdebug']['remote_autostart'] = 1
default['php']['xdebug']['remote_host'] = '192.168.50.1'
default['php']['xdebug']['remote_port'] = 9000
default['php']['xdebug']['profiler_enable'] = 1
default['php']['xdebug']['profiler_output_dir'] = '/tmp'
default['php']['xdebug']['max_nesting_level'] = 1000
default['php']['xdebug']['idekey'] = 'INTELLIJ'


