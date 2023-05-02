. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "Manual request to reset"

if ( GetRemovalItems -badChars $badChars  ) {
	
	Write-Host "bad chars found"
	
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null

} else {
	
	Write-Host "no bad chars found fix not needed"

}