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
	)][string]$appVersion = $null,
	[Parameter(
		Position = 3
	)][bool]$isSilent = $false
)

$codeList = [System.Collections.ArrayList]::new()
$codeList.Add($true) | Out-Null

$appPaths = @(
	"/System/Applications"
	"/Applications"
)
function writeOut {
	param (
		[Parameter(
			ValueFromPipeline = $true
		)]
		[string]$outString
	)

	if ($isSilent) {
		return
	}

	Write-Output $outString

}
function checkProfile {
	param(
	)

	$profileNames = sudo profiles show | grep $profileName

	if ($null -eq $profileNames -or ($profileNames | ForEach-Object { $_ -like "*$profileName*" }) -contains $false) {
		"$profileName not installed" | writeOut
		return $false
	}
	if (!$isSilent) {

	}
	"$profileName installed" | writeOut
	return $true

}

function checkApp {
	param()
	
	foreach ($a in $appPaths) {
		if (Test-Path -Path "$a/$appName") {
			"install location $a/$appName" | writeOut
			return $true
		}
	}

	"$appName install not found" | writeOut
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
		"$appName version not found" | writeOut
		return $false
	}

	if ($versionString -ne $appVersion) {
		"expected to find ""$appversion"" and found ""$versionString""" | writeOut
		return $false
	}

	"$versionString" | writeOut
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
	"Error" | writeOut
	return $false
}

return $true