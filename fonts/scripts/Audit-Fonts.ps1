. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

# foreach ($font in $fonts) {
# 	if (checkFont -Font $font -Libraries $libraries) {
# 		Write-Host "missing font detected"
# 		New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
# 		exit
# 	}
# }
if ( (checkForFonts -Fonts $fonts -Libraries $libraries) ) {
	Write-Host "missing font(s) detected"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
} else {
	Write-Host "no missing fonts detected"
}