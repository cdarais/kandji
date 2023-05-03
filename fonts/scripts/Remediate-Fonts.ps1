. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$uri = "$($args[1])/data"

Write-Host "installing missing fonts"
foreach ( $font in (checkForFonts -FontsToCheck $fonts) ) {
	Write-Host "installing $font"
	Invoke-WebRequest -Uri "$uri/$font" -OutFile "$($libraries[0])/$font"
}

Invoke-Expression "$($args[0])/Audit-Fonts.ps1 $($args[0])"