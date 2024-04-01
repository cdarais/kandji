$folderChecks = @(
	"Application Support/Microsoft",
	"Group Containers/UBF8T346G9.com.microsoft.teams",
	"com.microsoft.teams2.notificationcenter",
	"com.microsoft.teams2.respawn"
)

$excludedUsers = @(
	"root",
	"admin",
	"wadmin"
)

$fileChecks = @(
	"Teams"
)
$folderChecks | Out-Null
$excludedUsers | Out-Null
$fileChecks | Out-Null