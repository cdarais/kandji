Write-Host "Manual request to reset"
New-Item -Path "$($args[0])/1" -ItemType File | Out-Null