
normal[:netcalc][:version] = '0.1.0-rc.2'
normal[:netcalc][:package_source] = "https://github.com/cantenesse/netcalc/archive/#{normal[:netcalc][:version]}.zip"
normal[:netcalc][:python][:packages] = ['distribute']
normal[:netcalc][:python][:pip_packages] = ['tornado', 'IPy']
# This is something to be overriden by environment definitions outside of vagrant env
normal[:netcalc][:deploy][:manager] = '10.10.10.3'
