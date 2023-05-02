$badChars = @(
	'~',
	'"',
	'*',
	':',
	'<',
	'>',
	'?',
	'/',
	'\',
	'|'
	'#',
	'%',
	'&',
	'{',
	'}'
)

$excludedUsers = @(
	"root",
	"admin",
	"wadmin"
)

$currentUser = Write-Output "show State:/Users/ConsoleUser" | scutil | awk '/Name :/ { print $3 }'
$uid = id -u "$currentUser"

$badChars | Out-Null
$excludedUsers | Out-Null
$uid | Out-Null