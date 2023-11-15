sudoersFile="/etc/sudoers"
currentUser=$(echo "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }')
localDictionary=/Users/$currentUser/Library/Spelling/LocalDictonary
""

declare -a dockApps=(
	"workstream"
)