. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"


Write-Host "attempting to resolve discrepencies"


Invoke-Expression "$($args[0])/Audit-MySQLWorkbench.ps1 $($args[0])"