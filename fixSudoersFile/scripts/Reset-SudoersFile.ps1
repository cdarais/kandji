. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"

Write-Host "attempting to resolve discrepencies"

Out-File -FilePath $sudoersFile
$defaultSudoersData | Out-File -FilePath $sudoersFile -Append

Invoke-Expression "$($args[0])/Audit-SudoersFile.ps1 $($args[0])"