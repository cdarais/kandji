Write-Host "Manual request to collect apps"
New-Item -Path "$($args[0])/1" -ItemType File | Out-Null