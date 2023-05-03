. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$uri = "$($args[1])/data"

Write-Host "installing missing fonts"
foreach ($font in $fonts) {
	if (checkFont -Font $font -Libraries $libraries) {
		Write-Host "installing $font"
		Invoke-WebRequest -Uri "$uri/$font" -OutFile "$($args[0])/$font"
		sudo mv "$($args[0])/$font" "$($libraries[0])"
	}
}

Invoke-Expression "$($args[0])/Audit-Fonts.ps1 $($args[0])"