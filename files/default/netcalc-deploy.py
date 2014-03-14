import os
import time
import urllib
import zipfile

def transitioning(node, version):
	payload = "'node=%s status=transitioning to=%s'" % (node, version)
	os.system("serf event netcalc-status %s" % payload)

def transitioned(node, version):
	payload = "'node=%s status=transitioned version=%s'" % (node, version)
	os.system("serf event netcalc-status %s" % payload)

def execute(hostname, event, payload, raw_payload):
    if event != 'netcalc-restart':
        return
    if 'node' not in payload or hostname != payload['node']:
        return
    ## NKG: Should be set against the linked directory.
    old_version = '1.0.0'
    version = payload['version']

    transitioning(payload['node'], version)
    ## NKG: This version needs to be set dynamically some how.
    os.system('serf tags -set=netcalc=%s,stopping' % old_version)
    os.system('sudo su -c "service netcalc stop"')
    os.system('serf tags -set=netcalc=%s,stopped' % old_version)

    ## NKG: To make this semi-legit, the source file should be downloaded to
    ## a tmp file someplace and comparisons made against any existing source
    ## files or extracted directories.
    download_source = 'https://github.com/cantenesse/netcalc/archive/%s.zip' % version
    download_destination = '/home/tornado/netcalc/app/%s.zip' % version
    ## NKG: Should bail if there were any problems downloading the file to the destination.
    urllib.urlretrieve(download_source, download_destination)

    ## NKG: Should make sure this file exists.
    zfile = zipfile.ZipFile(download_destination)
    zfile.extractall('/home/tornado/netcalc/app/')

    ## NKG: Should make sure this link/directory exists.
    os.unlink('/home/tornado/netcalc/app/current/')
    os.symlink('/home/tornado/netcalc/app/%s' % version, '/home/tornado/netcalc/app/current/')

    ## NKG: Should make sure this link/directory exists.
    st = os.stat('/home/tornado/netcalc/app/current/netcalc_listener.py')
    os.chmod('/home/tornado/netcalc/app/current/netcalc_listener.py', st.st_mode | stat.S_IEXEC)

    os.system('serf tags -set=netcalc=%s,started' % version)
    os.system('sudo su -c "service netcalc start"')
    os.system('serf tags -set=netcalc=%s,running' % version)
    transitioned(payload['node'], version)
    ## NKG: If there is a failure during the upgrade, the `netcalc` tag
    ## should be `netcalc=[old_version],stopped` and the transitioned event
    ## sent.
