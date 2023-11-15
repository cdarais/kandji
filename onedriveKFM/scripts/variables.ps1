$plist = "/Users/chris.darais/Library/Preferences/com.microsoft.OneDrive.plist"
$tenantID = "610f13d2-8af5-4f2d-92ec-4b85db09cd61"
$oneDriveVersion = "Production"
$bools = @(
	@{ name = "DisableHydrationToast"; bool = $true },
	@{ name = "DisablePersonalSync"; bool = $true },
	@{ name = "DisableTutorial"; bool = $true },
	@{ name = "HideDockIcon"; bool = $true },
	@{ name = "OpenAtLogin"; bool = $true },
	@{ name = "KFMSilentOptInDesktop"; bool = $true },
	@{ name = "KFMSilentOptInDocuments"; bool = $true },
	@{ name = "KFMSilentOptInWithNotification"; bool = $true }
)

$dicts = @(
	@{ name = "AllowTenantList";
		values = @{
			key = $tenantId;
			value = "<true/>"
		}
	}
)

$arrays = @(
	@{
		name = "EnableODIgnore";
		values = @(
			"*.DS_Store"
		)
	}
)

$strings = @(
	@{ name = "KFMSilentOptIn"; value = $tenantID },
	@{ name = "Tier"; value = $oneDriveVersion }
)

$plist | Out-Null
$bools | Out-Null
$dicts | Out-Null
$arrays | Out-Null
$strings | Out-Null