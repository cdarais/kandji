. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$uri = "$($args[1])/data"
$webDownloader = New-Object net.webclient

Write-Host "installing missing fonts"

foreach ($missingFont in checkForFonts) {
	Write-Host "installing $missingFont"
	$webDownloader.DownloadFile("$uri/$missingFont", "$($libraries[0])/$missingFont")
}