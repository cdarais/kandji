. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"


Write-Host "resetting google drive files"

foreach ($char in $badChars) {
	While ( (Get-ChildItem -Path "/Users/$currentUser/Google Drive/My Drive" -Force -Directory | Where-Object { $_.Name.ToLower().Contains($char) }) ) {
		$item = (Get-ChildItem -Path "/Users/$currentUser/Google Drive/My Drive" -Force -Directory | Where-Object { $_.Name.ToLower().Contains($char) })[0]
		Rename-Item -Path $item.FullName -NewName $item.Name.Replace($char, "_")
	}
}

foreach ($char in $badChars) {
	While ( (Get-ChildItem -Path "/Users/$currentUser/Google Drive/My Drive" -Force | Where-Object { $_.Name.ToLower().Contains($char) }) ) {
		$item = (Get-ChildItem -Path "/Users/$currentUser/Google Drive/My Drive" -Force | Where-Object { $_.Name.ToLower().Contains($char) })[0]
		Rename-Item -Path $item.FullName -NewName $item.Name.Replace($char, "_")
	}
}


Invoke-Expression "$($args[0])/Audit-GoogleDriveFiles.ps1 $($args[0])"