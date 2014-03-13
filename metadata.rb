name             'netcalc'
maintainer       'Chris Antenesse'
maintainer_email 'chris@antenesse.net'
license          'All rights reserved'
description      'Installs/Configures netcalc'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apt", "~> 2.3.8"
depends "haproxy", "~> 1.6.2"
depends 'python'
depends 'ark'
depends 'serf'
depends 'helot'