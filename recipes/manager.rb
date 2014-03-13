#
# Cookbook Name:: netcalc
# Recipe:: manager
#
# Copyright (C) 2014 Chris Antenesse
# 
# All rights reserved - Do Not Redistribute
#


node.default["helot"]["client"]["node_name"] = "netcalc01.us.blah"

node.default["serf"]["agent"]["tags"]["apps"] = "netcalc"
node.default["serf"]["agent"]["tags"]["netcalc"] = node[:netcalc][:version] + ",stopped"

include_recipe "helot::serf"

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