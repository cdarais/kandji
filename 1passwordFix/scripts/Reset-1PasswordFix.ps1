. "$($args[0])/variables.ps1"

Write-Host "resetting 1password files"

Get-Process | Where-Object { $_.Name -like "*1pass*" } | Stop-Process

foreach ($user in (Get-ChildItem -Path "/Users" | Where-Object { $excludedUsers -notcontains $_.user })) {
	
	foreach ($folderCheck in $folderChecks) {
		$folder = Get-ChildItem -Path "/Users/$($user.name)/Library/$folderCheck"
		
		foreach ($fileCheck in $fileChecks) {
			$folder | Where-Object { $_.name -like "*$fileCheck*" } | Remove-Item -Force | Out-Null
		}
	
	}
}