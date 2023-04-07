. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$uri = "$($args[1])/data"

Write-Host "missing font count: $($missingFonts.count)"
Write-Host "installing"
foreach ($missingFont in checkForFonts) {
	Invoke-WebRequest -Uri "$uri/$missingFont" -OutFile "$($libraries[0])/$missingFont"
}