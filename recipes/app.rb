#
# Cookbook Name:: netcalc
# Recipe:: app
#
# Copyright (C) 2014 Chris Antenesse
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"
include_recipe "python"

group "tornado" do
  group_name "tornado"
  gid 2000
  action :remove
  action :create
end

user "tornado" do
  username "tornado"
  home "/home/tornado"
  uid 2000
  gid 2000
  action :remove
  action :create
  supports ({ :manage_home => true })
end

template "/etc/init/netcalc.conf" do
  source "netcalc-upstart.conf.erb"
  mode 0444
  owner "root"
  group "root"
end

node[:netcalc][:python][:packages].each do |package|
  package "python-" + package
end

package "curl" do
  action :install
end

node[:netcalc][:python][:pip_packages].each do |pip|
  python_pip pip
end

package 'unzip' do
	action :install
end

remote_file "#{Chef::Config[:file_cache_path]}/netcalc-#{node[:netcalc][:version]}.zip" do
  source node[:netcalc][:package_source]
end

directory "/home/tornado/netcalc/app/" do
  owner 'tornado'
  group 'tornado'
  recursive true
  action :create
end

bash 'extract_app' do
  cwd "/home/tornado/netcalc/app/"
  code <<-EOH
    unzip #{Chef::Config[:file_cache_path]}/netcalc-#{node[:netcalc][:version]}.zip
  EOH
  not_if { ::File.exists?('/home/tornado/netcalc/app/netcalc-#{node[:netcalc][:version]}/netcalc_listener.py') }
end

link "/home/tornado/netcalc/app/current/" do
  to "/home/tornado/netcalc/app/netcalc-#{node[:netcalc][:version]}/"
end

file "/home/tornado/netcalc/app/current/netcalc_listener.py" do
  mode 00777
end
