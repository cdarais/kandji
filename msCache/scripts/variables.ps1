$folderChecks = @(
	"Application Support/Microsoft",
	"Group Containers/UBF8T346G9.com.microsoft.teams"
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