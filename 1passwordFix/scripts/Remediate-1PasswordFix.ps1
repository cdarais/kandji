. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "resetting 1password files"

StopProcesses

$items = New-Object System.Collections.ArrayList
$items.Add((GetRemovalItems -excludedUsers $excludedUsers -folderChecks $folderChecks -fileChecks $fileChecks)) | Out-Null

foreach ($i in $items ) {
	if ( Test-Path -Path $i.FullName ) {
		if ($i.GetType().Name -eq "FileInfo") {
			$i | Remove-Item -Force
		} else {
			$i | Remove-Item -Recurse -Force
		}
	}
}

Invoke-Expression "$($args[0])/Audit-1PasswordFix.ps1 $($args[0])"