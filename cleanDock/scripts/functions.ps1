function runAsUser {
	[CmdletBinding()]
	param (
		[Parameter(
			Position = 0
		)][string]$userId,
		[Parameter(
			Position = 1
		)][string]$userName,
		[Parameter(
			Position = 2
		)][string]$ctlCommand

	)

	if ($userName -ne "loginwindow") {
		# launchctl asuser "$userId" sudo -u "$userName" "/usr/bin/$ctlCommand"
		launchctl asuser "$userId" """/usr/bin/$ctlCommand"""
	}
}

function addAppItem {
	[CmdletBinding()]
	param (
		[Parameter(
			Position = 0
		)][string]$itemName,
		[Parameter(
			Position = 1
		)][string]$userId,
		[Parameter(
			Position = 2
		)][string]$userName,
		[Parameter(
			Position = 3
		)][string]$dock
	)

	$item = "<dict><key>tile-data</key><dict><key>file-data</key><dict>"
	$item += "<key>_CFURLString</key><string>"
	$item += $itemName
	$item += "</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

	runAsUser -userId $userId -userName $userName -ctlCommand "defaults write $dock persistent-apps -array-add ""$item"""
}
function addOtherItem {
	[CmdletBinding()]
	param (
		[Parameter(
			Position = 0
		)][string]$itemName,
		[Parameter(
			Position = 1
		)][string]$userId,
		[Parameter(
			Position = 2
		)][string]$userName,
		[Parameter(
			Position = 3
		)][string]$dock
	)

	$item = "<dict><key>tile-data</key><dict><key>file-data</key><dict>"
	$item += "<key>_CFURLString</key><string>"
	$item += $itemName
	$item += "</string><key>_CFURLStringType</key><integer>0</integer></dict>"
	$item += "<key>file-label</key><string>Downloads</string><key>file-type</key><string>2</string></dict>"
	$item += "<key>tile-type</key><string>directory-tile</string></dict>"

	runAsUser -userId $userId -userName $userName -ctlCommand "defaults write $dock persistent-others -array-add ""$item"""

}

function waitForDock {
	param()

	while (!(Get-Process | Where-Object { $_.ProcessName -eq "Dock" })) {
		Write-Host "Dock not running sleeping 5 seconds"
		Start-Sleep -Seconds 5
	}

}