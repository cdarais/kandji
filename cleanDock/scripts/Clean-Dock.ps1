. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

waitForDock

Write-Host "cleaning dock"

defaults delete /Users/$userName/Library/Preferences/com.apple.dock persistent-apps
defaults delete /Users/$userName/Library/Preferences/com.apple.dock persistent-others

Write-Host "adding apps"

foreach ($app in $dockApps) {
	Write-Host $app
	$app | addAppItem
}

foreach ($app in $dockOthers) {
	Write-Host $app
	$app | addOtherItem
}

Write-Host "disabling recent items"
defaults write com.apple.dock show-recents -bool FALSE

Write-Host "enabling minimize into dock"
defaults write com.apple.dock minimize-to-application -bool yes

Write-Host "restarting dock"
killall Dock