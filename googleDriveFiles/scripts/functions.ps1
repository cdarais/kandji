function GetRemovalItems {
	param (
		$excludedUsers,
		$folderChecks,
		$badChars
	)

	$itemsToRename = New-Object System.Collections.ArrayList


	foreach ($user in (Get-ChildItem -Path "/Users" | Where-Object { $excludedUsers -notcontains $_.user })) {
	
		foreach ($folderCheck in $folderChecks) {
			$folder = Get-ChildItem -Path "/Users/$currentUser/Google Drive/My Drive"
			
			foreach ($char in $badChars) {
	
				foreach ($file in ($folder | Where-Object { $_.name -match $char })) {
		
					$itemsToRename.Add($file) | Out-Null
				
				}
			}
		}
	}

	return $itemsToRename
}