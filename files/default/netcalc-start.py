import os

def execute(payload):
    os.system('sudo su -c "service netcalc start"')

    return True