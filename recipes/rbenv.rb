# --------------------------------------------------
# install rbenv
# --------------------------------------------------
git "/usr/local/rbenv" do                                                                                                                                                         
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :sync
end

%w{/usr/local/rbenv/shims /usr/local/rbenv/versions}.each do |dir|
  directory dir do
    action :create 
  end 
end

# --------------------------------------------------
# install ruby-build
# --------------------------------------------------
git "/usr/local/ruby-build" do  
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :sync
end

bash "install_ruby_build" do
  cwd "/usr/local/ruby-build"
  code <<-EOH
    ./install.sh
  EOH
end

template "rbenv.sh" do
  path "/etc/profile.d/rbenv.sh"
  owner "root"
  group "root"
  mode "0644"
  source "rbenv.sh.erb"
end

%w{make gcc zlib-devel openssl-devel readline-devel ncurses-devel gdbm-devel db4-devel libffi-devel tk-devel libyaml-devel}.each do |pkg|
  yum_package pkg do
    action :install
  end 
end

# --------------------------------------------------
# build Ruby
# --------------------------------------------------
node['rbenv']['ruby']['versions'].each do |ruby_version|
  bash "rbenv install #{ruby_version}" do
    code "source /etc/profile.d/rbenv.sh; rbenv install #{ruby_version}"
    not_if { ::File.exists?("/usr/local/rbenv/versions/#{ruby_version}") }
  end
end

bash "rbenv global #{node['rbenv']['ruby']['global']}" do
  code "source /etc/profile.d/rbenv.sh; rbenv global #{node['rbenv']['ruby']['global']}"
end

bash "rbenv rehash" do
  code "source /etc/profile.d/rbenv.sh; rbenv rehash"
end