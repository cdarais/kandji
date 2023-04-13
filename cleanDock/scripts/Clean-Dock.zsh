#!/bin/zsh

source $1/variables.zsh
source $1/functions.zsh

if [[ -e /usr/local/bin/pwsh ]]
then
	installLatestDockUtil
	waitForDesktop

	# echo "Setting Launchpad to default"
	# runAsUser /usr/bin/defaults write com.apple.dock ResetLaunchPad -bool "false"

	echo "Disable show recent items"
	runAsUser /usr/bin/defaults write com.apple.dock "show-recents" -bool "false"

	echo "Enable Minimize Icons into Dock Icons"
	runAsUser /usr/bin/defaults write com.apple.dock "minimize-to-application" -bool "true"

	echo "Removing Dock Persistent Apps"
	runAsUser /usr/local/bin/dockutil --remove all --no-restart --allhomes
	
	echo "Adding Apps to Dock"
	for i in "${dockApps[@]}"
	do
		checkAndAddItem $i
	done

	echo "Adding Downloads Stack"
	runAsUser /usr/local/bin/dockutil --add '~/Downloads' --view auto --display stack --allhomes --no-restart
	
	echo "Restarting Dock"
	/usr/bin/killall Dock
fi