. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"


Write-Host "resetting google drive files"

$items = New-Object System.Collections.ArrayList
$items.Add((GetRemovalItems -badChars $badChars)) | Out-Null
$items.Count
foreach ($i in $items ) {
	foreach ($char in $badChars) {
		# Rename-Item -Path $i.FullName -NewName $i.Name.Replace($char, "")
	}
}

Invoke-Expression "$($args[0])/Audit-GoogleDriveFiles.ps1 $($args[0])"