. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"


if ( (checkForFonts -Fonts $fonts -Libraries $libraries) ) {
	Write-Host "missing font(s) detected"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
}
else {
	Write-Host "no missing fonts detected"
}