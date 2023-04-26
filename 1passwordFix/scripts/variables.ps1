$folderChecks = @(
	"Application Support",
	"Containers",
	"Group Containers",
	"Preferences"
)

$excludedUsers = @(
	"root",
	"admin",
	"wadmin"
)

$fileChecks = @(
	"1password",
	"com.agilebits",
	"onepassword"
)
$folderChecks | Out-Null
$excludedUsers | Out-Null
$fileChecks | Out-Null