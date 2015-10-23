package "httpd" do
  action :install
end
service "httpd" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable , :start ]
end

template "/etc/httpd/conf/httpd.conf" do
  owner "root"
  mode  0644
  source "httpd.conf.erb"
end