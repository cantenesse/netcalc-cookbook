import os

def execute(hostname, event, payload, raw_payload):
    if event != 'netcalc-stop':
        return
    if 'node' not in payload or hostname != payload['node']:
        return
    ## NKG: This version needs to be set dynamically some how.
    os.system('serf tags -set=netcalc=1.0.0,stopping')
    os.system('sudo su -c "service netcalc stop"')
    os.system('serf tags -set=netcalc=1.0.0,stopped')
