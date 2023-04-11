#!/bin/zsh
base=$1
source $base/variables.zsh
source $base/functions.zsh

# if [[ -e /usr/local/bin/pwsh ]]
# then
	installLatestDockUtil
	waitForDesktop
	echo "Removing Dock Persistent Apps"
	runAsUser defaults delete com.apple.dock persistent-apps
	runAsUser defaults delete com.apple.dock persistent-others

	echo "$(date) | Adding file path to Finder"
	runAsUser defaults write com.apple.dock ResetLaunchPad -bool TRUE

	echo "Adding Apps to Dock"
	for i in "${dockApps[@]}"
	do
		if [[ -e $i ]]
		then
			echo "Adding $i to Dock"
			# runAsUser defaults write com.apple.dock persistent-apps -array-add $persistentApp
			runAsUser /usr/local/bin/dockutil --add $i --no-restart
		fi
	done

# 	# echo "$(date) | Adding Downloads Stack"
# 	# runAsUser /usr/local/bin/kandji dock --add $otherAppDownloadFolder

# 	echo "Disable show recent items"
# 	runAsUser defaults write com.apple.dock show-recents -bool FALSE

# 	echo "Enable Minimize Icons into Dock Icons"
# 	runAsUser defaults write com.apple.dock minimize-to-application -bool TRUE
	
# 	# echo "$(date) | Adding Downloads Stack"
# 	echo "$(date) | Restarting Dock"
# 	# echo $otherAppDownloadFolder
# 	# sudo /usr/local/bin/kandji dock $otherAppDownloadFolder --all
	killall Dock

# 	echo "$(date) | Adding file path to Finder"
# 	runAsUser defaults write com.apple.finder "ShowPathbar" -bool TRUE

# 	echo "$(date) | Setting up auto delete for trash"
# 	runAsUser defaults write com.apple.finder "FXRemoveOldTrashItem" -bool "true"



# 	echo "$(date) | Restarting Finder"
# 	killall Finder
# 	exit 0
# fi

# exit 1