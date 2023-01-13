
$serial = zsh -c @'
system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'
'@

$token = "e1df0410-4913-4e1d-9e09-7f99fe813f8f"
$baseUrl = "https://workboard.clients.us-1.kandji.io/api/v1"
$approvedAppsUrl = "https://raw.githubusercontent.com/cdarais/kandji/main/removal/approvedApps.json"

$allowedApps = (Invoke-WebRequest -uri $approvedAppsUrl).Content | ConvertFrom-Json -depth 100
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $token")

$deviceID = ((Invoke-WebRequest -Uri "$baseUrl/devices?device_name=$serial" -Headers $headers -Method Get).Content | ConvertFrom-Json -Depth 100).device_id

$foundApps = ((Invoke-WebRequest -Uri "$baseUrl/devices/$deviceID/apps" -Headers $headers -Method Get).Content | ConvertFrom-Json -Depth 100).apps | Select-Object "app_name", "bundle_id", "source", "path", "process"



foreach ($app in $foundApps) {

    if ( -not ($allowedApps | Where-Object { $_.app_name -eq $app.app_name -and $_.source -eq $app.source -and $_.bundle_id -eq $app.bundle_id -and $_.path -eq $app.path }) ) {
        
        do {
            Write-Host "killing proccess $($app.app_name)"
            $process = Get-Process | Where-Object { $_.ProcessName -eq $app.app_name }
            if ($process) { Stop-Process -Id $process.Id }
        } while (Get-Process | Where-Object { $_.Name -eq $app.app_name })

        while (Test-Path -Path $app.path) {
            # zsh -c "rm -rf $($app.path)"

            Start-Sleep -Seconds 1
        }
        Write-Host "Successfully removed: $($app.app_name)"
    }
}