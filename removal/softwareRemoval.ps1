
$serial = zsh -c @'
system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'
'@

$token = "e1df0410-4913-4e1d-9e09-7f99fe813f8f"
$baseUrl = "https://workboard.clients.us-1.kandji.io/api/v1"
$approvedAppsUrl = "https://raw.githubusercontent.com/cdarais/kandji/main/removal/approvedApps.json"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $token")

$allowedApps = (Invoke-WebRequest -uri $approvedAppsUrl).Content | ConvertFrom-Json -depth 100

$deviceID = ((Invoke-WebRequest -Uri "$baseUrl/devices?device_name=$serial" -Headers $headers -Method Get).Content | ConvertFrom-Json -Depth 100).device_id

$foundApps = ((Invoke-WebRequest -Uri "$baseUrl/devices/$deviceID/apps" -Headers $headers -Method Get).Content | ConvertFrom-Json -Depth 100).apps | Select-Object "app_name", "bundle_id", "source", "path", "process"

$noAppFound= $true

foreach ($app in $foundApps) {

    if ( -not ($allowedApps | Where-Object { $_.app_name -eq $app.app_name -and $_.source -eq $app.source -and $_.bundle_id -eq $app.bundle_id -and $_.path -eq $app.path }) ) {
        $noAppFound = $false
        $processName = $app.app_name
        $path = $app.path

        Write-Host "removing $($app.app_name)"
        
        if($processName.length -gt 15) {
            $processName = $processName.substring(0, 15)
        }
        while (Get-Process | Where-Object { $_.Name -eq $processName }) {
            Write-Host "killing proccess $($app.app_name)"
            $process = Get-Process | Where-Object { $_.ProcessName -eq $processName }
            if ($process) { Stop-Process -Id $process.Id }
            Start-Sleep -Seconds 1
        }

        while (Test-Path -Path $path) {
            rm -rf $path
            Start-Sleep -Seconds 1
        }
        Write-Host "Successfully removed: $($app.app_name)"
    } 
}

if ($noAppFound) {
    Write-Host "No apps to be removed found"
}