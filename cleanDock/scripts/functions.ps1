function addAppItem {
	[CmdletBinding()]
	param (
		[Parameter(
			Position = 0,
			ValueFromPipeline = $true
		)][string]$itemName
	)

	$item = + "<dict><key>tile-data</key><dict><key>file-data</key><dict>"
	$item = $item + "<key>_CFURLString</key><string>"
	$item = $item + "$itemName"
	$item = $item + "</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>"

	defaults write $dock persistent-apps -array-add $item
}
function addOtherItem {
	[CmdletBinding()]
	param (
		[Parameter(
			Position = 0,
			ValueFromPipeline = $true
		)][string]$itemName
	)

	$item = "<dict><key>tile-data</key><dict><key>file-data</key><dict>"
	$item = $item + "<key>_CFURLString</key><string>"
	$item = $item + "$itemName"
	$item = $item + "</string><key>_CFURLStringType</key><integer>0</integer></dict>"
	$item = $item + "<key>file-label</key><string>Downloads</string><key>file-type</key><string>2</string></dict>"
	$item = $item + "<key>tile-type</key><string>directory-tile</string></dict>"

	defaults write $dock persistent-others -array-add $item

}

function waitForDock {
	param()

	while (!(Get-Process | Where-Object { $_.ProcessName -eq "Dock" })) {
		Write-Host "Dock not running sleeping 5 seconds"
		Start-Sleep -Seconds 5
	}

}