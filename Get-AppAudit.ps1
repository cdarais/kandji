[CmdletBinding()]
param (
	[Parameter (
		Position = 0
	)]
	[string]$profileName = $null,
	[Parameter (
		Position = 1
	)][string]$appName = $null,
	[Parameter(
		Position = 2
	)][string]$appVersion = $null
)

$codeList = [System.Collections.ArrayList]::new()
$codeList.Add($true) | Out-Null

$appPaths = @(
	"/System/Applications"
	"/Applications"
)

function checkProfile {
	param(
	)

	$profileNames = sudo profiles show | grep $profileName

	if ($null -eq $profileNames -or ($profileNames | ForEach-Object { $_ -like "*$profileName*" }) -contains $false) {
		Write-Host "$profileName not installed"
		return $false
	}
	Write-Host "$profileName installed"
	return $true

}

function checkApp {
	param()
	
	foreach ($a in $appPaths) {
		if (Test-Path -Path "$a/$appName") {
			Write-Host "install location $a/$appName"
			return $true
		}
	}

	Write-Host "$appName install not found"
	return $false

}

function checkVersion {
	param ()

	$versionString = $null
	
	foreach ($a in $appPaths) {
		if (Test-Path -Path "$a/$appName") {
			$versionString = sudo defaults read "$a/$appName/Contents/Info.plist" CFBundleShortVersionString
		}
		if ($versionString) { break }
	}

	if ($null -eq $versionString) {
		Write-Host "$appName version not found"
		return $false
	}

	if ($versionString -ne $appVersion) {
		Write-Host "expected to find ""$appversion"" and found ""$versionString"""
		return $false
	}

	Write-Host "$versionString"
	return $true
}

if ($profileName) {
	$codeList.Add((checkProfile)) | Out-Null
}

if ($appName) {
	$codeList.Add((checkApp)) | Out-Null
}

if ($appVersion) {
	$codeList.Add((checkVersion)) | Out-Null
}

if ($codeList -contains $false) {
	Write-Host "Error"
	exit 1
}

exit $true