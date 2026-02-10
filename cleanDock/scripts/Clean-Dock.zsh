#!/bin/zsh

source $1/variables.zsh
source $1/functions.zsh

if [[ -e /usr/local/bin/pwsh ]]
then
	installLatestDockUtil
	waitForDesktop

	echo "Disable show recent items"
	runAsUser /usr/bin/defaults write com.apple.dock show-recents -bool "false"

	echo "Enable Minimize Icons into Dock Icons"
	runAsUser /usr/bin/defaults write com.apple.dock minimize-to-application -bool TRUE

	echo "Removing Dock Persistent Apps"
	runAsUser /usr/local/bin/dockutil --remove all --no-restart --allhomes

	echo "Adding Apps to Dock"
	for i in "${dockApps[@]}"
	do
		checkAndAddItem $i
	done

	echo "Adding Downloads Stack"
	runAsUser /usr/local/bin/dockutil --add '~/Downloads' --view auto --display stack --allhomes --no-restart

	echo "Showing finder path bar"
	runAsUser /usr/bin/defaults write com.apple.finder ShowPathbar -bool "true"

	echo "Changing default view"
	runAsUser /usr/bin/defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

	echo "Setting up trash purge"
	runAsUser /usr/bin/defaults write com.apple.finder FXRemoveOldTrashItems -bool "true"

	echo "Restarting Dock"
	/usr/bin/killall Dock

	echo "Restarting Finder"
	/usr/bin/killall Finder

fi