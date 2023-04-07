. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$uri = "$($args[1])/data"

$prevProgressPreference = $global:ProgressPreference
$global:ProgressPreference = 'SilentlyContinue'

Write-Host "installing missing fonts"
foreach ($missingFont in checkForFonts) {
	Write-Host "installing $missingFont"
	Invoke-WebRequest -Uri "$uri/$missingFont" -OutFile "$($libraries[0])/$missingFont"
}

$global:ProgressPreference = $prevProgressPreference