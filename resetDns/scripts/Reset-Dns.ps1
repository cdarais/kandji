Write-Host "resetting dns"

try {
	dscacheutil -flushcache
}
catch {}

try {
	killall -HUP mDNSResponder
}
catch {
	Write-Host "mDNSResponder not running"
}
