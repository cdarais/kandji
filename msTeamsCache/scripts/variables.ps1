$folderChecks = @(
	"Application Support/Microsoft"
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