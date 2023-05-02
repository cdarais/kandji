. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$uri = "$($args[1])/data"

Write-Host "installing missing fonts"
foreach ( $missingFont in (checkForFonts) ) {
	Write-Host "installing $missingFont"
	Invoke-WebRequest -Uri "$uri/$missingFont" -OutFile "$($libraries[0])/$missingFont"
}

Invoke-Expression "$($args[0])/Audit-Fonts.ps1 $($args[0])"