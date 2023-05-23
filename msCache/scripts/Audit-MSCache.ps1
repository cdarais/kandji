. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "Manual request to reset"

if ( GetRemovalItems -excludedUsers $excludedUsers -folderChecks $folderChecks -fileChecks $fileChecks  ) {
	
	Write-Host "ms teams files found"
	
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null

} else {
	
	Write-Host "no ms teams files found fix not needed"

}