#
# Cookbook Name:: netcalc
# Recipe:: manager
#
# Copyright (C) 2014 Chris Antenesse
# 
# All rights reserved - Do Not Redistribute
#


node.default["helot"]["client"]["app"]["name"] = "netcalc"
node.default["helot"]["client"]["app"]["version"] = node[:netcalc][:version]
node.default["helot"]["client"]["tags"] = node[:netcalc][:version] + ",stopped"
node.default["helot"]["client"]["node_name"] = "netcalc01.us.blah"

include_recipe "helot::client"

directory "/opt/serf/event_handlers/plugins" do
  action :create
  owner "serf"
  group "serf"
end

cookbook_file "/opt/serf/event_handlers/plugins/netcalc-start.py" do
  source "netcalc-start.py"
  mode 0755
  owner "serf"
  group "serf"
end

cookbook_file "/opt/serf/event_handlers/plugins/netcalc-stop.py" do
  source "netcalc-stop.py"
  mode 0755
  owner "serf"
  group "serf"
end