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

foreach ($user in (Get-ChildItem -Path "/Users" | Where-Object { $excludedUsers -notcontains $_.user })) {
	foreach ($folderCheck in $folderChecks) {
		$folder = Get-ChildItem -Path "/Users/$($user.name)/Library/$folderCheck"
		foreach ($fileCheck in $fileChecks) {
			$folder | Where-Object { $_.name -like "*$fileCheck*" } | Remove-Item -Recurse -Force
		}
	}
}