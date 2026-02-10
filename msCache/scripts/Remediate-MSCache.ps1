. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "resetting ms teams files"

StopProcesses

$items = New-Object System.Collections.ArrayList
$items.Add((GetRemovalItems -excludedUsers $excludedUsers -folderChecks $folderChecks -fileChecks $fileChecks)) | Out-Null

foreach ($i in $items ) {
	if ($i.GetType().Name -eq "FileInfo") {
		$i | Remove-Item -Force
	}
 else {
		$i | Remove-Item -Recurse -Force
	}
}

Invoke-Expression "$($args[0])/Audit-MSCache.ps1 $($args[0])"