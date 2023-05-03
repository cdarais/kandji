. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$missingFonts = checkForFonts
$missingFonts

if ($null -ne $missingFonts) {
	Write-Host "missing font count: $($missingFonts.Count)"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
} else {
	Write-Host "no missing fonts detected"
}