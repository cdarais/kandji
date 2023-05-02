function GetRemovalItems {
	param (
		$excludedUsers,
		$folderChecks,
		$badChars
	)

	$itemsToRename = New-Object System.Collections.ArrayList


	
	$files = Get-ChildItem -Path "/Users/$currentUser/Google Drive/My Drive"
	ls "/Users/$currentUser/Google Drive/My Drive"
			
	foreach ($char in $badChars) {
	
		foreach ($file in ($files | Where-Object { $_.name.Contains($char) })) {
		
			$itemsToRename.Add($file) | Out-Null
				
		}
	}

	return $itemsToRename
}