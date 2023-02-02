function convertAppName {
    param(
        $appName
    )

    switch ($appName) {
        "TeamViewerHost" { 
            Return "Teamviewer"
        }
        Default {
            Return $appName
        }
    }
}


$serial = zsh -c @'
system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'
'@

$token = $args[0]

$baseUrl = "https://workboard.clients.us-1.kandji.io/api/v1"
$approvedAppsUrl = "https://raw.githubusercontent.com/cdarais/kandji/main/removal/approvedApps.json"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Bearer $token")

$ProgressPreference = 'SilentlyContinue'
$allowedApps = (Invoke-WebRequest -uri $approvedAppsUrl).Content | ConvertFrom-Json -depth 100

$deviceID = ((Invoke-WebRequest -Uri "$baseUrl/devices?device_name=$serial" -Headers $headers -Method Get).Content | ConvertFrom-Json -Depth 100).device_id

$foundApps = ((Invoke-WebRequest -Uri "$baseUrl/devices/$deviceID/apps" -Headers $headers -Method Get).Content | ConvertFrom-Json -Depth 100).apps | Select-Object "app_name", "bundle_id", "source", "path", "process"
$ProgressPreference = 'Continue'

$noAppFound = $true
$failures = [System.Collections.ArrayList]::new() 

foreach ($app in $foundApps) {

    if ( -not ($allowedApps | Where-Object { $_.app_name -eq $app.app_name -and $_.source -eq $app.source -and $_.bundle_id -eq $app.bundle_id -and $_.path -eq $app.path }) ) {
        $noAppFound = $false
        
        Write-Host "removing $($app.app_name) in location $($app.path)"
        
        $processName = (convertAppName -appName $app.app_name)
        $alteredAppPath = $app.path.replace($app.app_name, $processName)

        if (pgre$processName){
            Write-Host "killing proccess $processName"
        }
                
        foreach ($p in (pgrep $processName)) {
            # $p = $p.replace($app.app_name, (convertAppName -appName $app.app_name))
            # $p -match '[0-9]+'
            # if ($matches[0]) {
            sudo kill -9 $p
        }
            # if ( (Get-Process | Where-Object { $_.Id -eq $matches[0] }) ) {
            #     sudo kill -9 $matches[0]
            # }
        # }
        #     Start-Sleep -Seconds 1
        #     $sleepCounter++
        # }
        
        # $sleepCounter = 0
        # while (Test-Path -Path $app.path) {
        #     if ($sleepCounter -gt 10) {
        #         Write-Host "failed to remove app path $($app.path)"
        #         [void]$failedRemovals.Add($app.path)
        #         break
        #     }
        
        sudo rm -rf $alteredAppPath
        sudo rm -rf $app.path

        if (Test-Path -Path $app.path) {
            $failures.Add("removal of $($app.app_name) with process $processName still has appPath of $($app.path)")
        }
        elseif (Test-Path -Path $alteredAppPath) {
            $failures.Add("removal of $($app.app_name) with process $processName still has appPath of $alteredPath")
        }
        else {
            Write-Host "successfully removed: $($app.app_name)"
        }
    }
}

if ($failures) {
    Write-Host "failed stops $failures"
    exit 1
}

if ($noAppFound) {
    Write-Host "No apps to be removed found"
}


# while ( pgrep $app.app_name ) {

    # if ($sleepCounter -gt 10) {
    #     Write-Host "failed to stop process $($app.app_name) processId $($pids)"
    #     [void]$failedStops.Add($app.app_name)
    #     break
    # }  