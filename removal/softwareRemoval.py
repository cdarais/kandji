import requests
import json
import subprocess

#get serial
system_profile_data = subprocess.Popen(
    ['system_profiler', '-json', 'SPHardwareDataType'], stdout=subprocess.PIPE)
data = json.loads(system_profile_data.stdout.read())
serial = data.get('SPHardwareDataType', {})[0].get('serial_number')

url = f"https://workboard.clients.us-1.kandji.io/api/v1/{serial}"

print(url)