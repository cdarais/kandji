Write-Host "One time dock clean"
New-Item -Path "$($args[0])/1" -ItemType File | Out-Null