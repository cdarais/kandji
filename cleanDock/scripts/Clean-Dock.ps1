. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

# waitForDock

Write-Host "cleaning dock"
Write-Host $dock
runAsUser -userId $userId -userName $userName -ctlCommand "defaults delete com.apple.dock persistent-apps"
runAsUser -userId $userId -userName $userName -ctlCommand "defaults delete com.apple.dock persistent-other"

Write-Host "adding apps"

foreach ($app in $dockApps) {
	Write-Host $app
	addAppItem -itemName $app -userName $userName -userId $userId
}

foreach ($app in $dockOthers) {
	Write-Host $app
	addOtherItem -itemName $app -userName $userName -userId $userId
}

Write-Host "disabling recent items"
runAsUser -userId $userId -userName $userName -ctlCommand "defaults write $dock show-recents -bool $false"

Write-Host "enabling minimize into dock"
runAsUser -userId $userId -userName $userName -ctlCommand "defaults write $dock minimize-to-application -bool $true"

Write-Host "restarting dock"
killall Dock