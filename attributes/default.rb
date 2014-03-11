
normal[:netcalc][:version] = '0.1.0-rc.1'
normal[:netcalc][:package_source] = "https://github.com/ngerakines/netcalc/archive/#{normal[:netcalc][:version]}.zip"
normal[:netcalc][:python][:packages] = ['distribute']
normal[:netcalc][:python][:pip_packages] = ['tornado', 'IPy']
