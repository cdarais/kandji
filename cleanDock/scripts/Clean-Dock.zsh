#!/bin/zsh

while [[ "$#" -gt 0 ]]
do case $1 in
	-b|--base) base="$2"
	shift;;
	*) echo "Unknown parameter passed: $1"
	exit 1;;
esac
	shift
done

source $base/variables.zsh
source $base/functions.zsh

if [[ -e /usr/local/bin/pwsh ]]
then
	installLatestDockUtil
	waitForDesktop

	echo "$(date) | Adding file path to Finder"
	runAsUser defaults write com.apple.dock ResetLaunchPad -bool FALSE

	echo "$(date) | Setting up auto delete for trash"
	runAsUser defaults write com.apple.finder "FXRemoveOldTrashItem" -bool "true"

	echo "Disable show recent items"
	runAsUser defaults write com.apple.dock show-recents -bool FALSE

	echo "Enable Minimize Icons into Dock Icons"
	runAsUser defaults write com.apple.dock minimize-to-application -bool TRUE

	echo "Removing Dock Persistent Apps"
	runAsUser /usr/local/bin/dockutil --remove all --no-restart
	
	echo "Adding Apps to Dock"
	for i in "${dockApps[@]}"
	do
		if [[ -e $i ]]
		then
			echo "Adding $i to Dock"
			runAsUser /usr/local/bin/dockutil --add $i --no-restart
		fi
	done

	echo "$(date) | Adding Downloads Stack"
	runAsUser /usr/local/bin/dockutil --add '~/Downloads' --view auto --display stack --allhomes
	
	echo "$(date) | Restarting Dock"
	killall Dock

	echo "$(date) | Restarting Finder"
	killall Finder
fi