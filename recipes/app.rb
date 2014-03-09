#
# Cookbook Name:: netcalc
# Recipe:: app
#
# Copyright (C) 2014 Chris Antenesse
# 
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

python_modules = ['IPy', 'tornado']

python_modules.each do |pymod|
  package "python-" + pymod
end
