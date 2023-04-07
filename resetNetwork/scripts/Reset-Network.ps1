. "$($args[0])/variables.ps1"

Write-Host "removing files"

foreach ($f in $files) {
	if (Test-Path -Path "$baseFilePath/$f") {
		Write-Host "$baseFilePath/$f"
		# sudo rm -f "$baseFilePath/$f"
	}
}