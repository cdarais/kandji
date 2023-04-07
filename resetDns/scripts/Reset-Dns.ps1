Write-Host "resetting dns"

dscacheutil -flushcache
killall -HUP mDNSResponder