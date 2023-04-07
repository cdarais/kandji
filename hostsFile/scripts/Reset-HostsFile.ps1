. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

$dockerApp = "/Applications/Docker.app"
$defaultHostsData = $plainHostsFile
$hostsFile = "/etc/hosts"

if (Test-Path -Path $dockerApp) {
	$defaultHostsData = $dockerHostsFile
}


Out-File -FilePath $hostsFile
$defaultHostsData | Out-File -FilePath $hostsFile -Append


/usr/local/bin/kandji display-alert --title "Success" --message "Reset hosts file back to default"


/usr/local/bin/pwsh "$($args[0])/Audit-HostsFile.ps1" $args[0]