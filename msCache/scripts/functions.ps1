function GetRemovalItems {
	param (
		$excludedUsers,
		$folderChecks,
		$fileChecks
	)

	$itemsToRemove = New-Object System.Collections.ArrayList


	foreach ($user in (Get-ChildItem -Path "/Users" | Where-Object { $excludedUsers -notcontains $_.user })) {
	
		foreach ($folderCheck in $folderChecks) {
			Write-Host "removing $folderCheck"
			$folder = Get-ChildItem -Path "/Users/$($user.name)/Library/$folderCheck"
			
			foreach ($fileCheck in $fileChecks) {
	
				foreach ($file in ($folder | Where-Object { $_.name -like "*$fileCheck*" })) {
		
					$itemsToRemove.Add($file) | Out-Null
				
				}
			}
		}
	}

	return $itemsToRemove
}

function StopProcesses {
	Get-Process | Where-Object { $_.Name -like "*teams*" } | Stop-Process
}