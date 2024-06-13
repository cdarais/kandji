function makeHeaders {
	param (
		$token
	)
	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$headers.Add("Content-type", "application/json")
	$headers.Add("Authorization", "Bearer $token")

	return $headers
}

function getDevice {
	param (
		$token,
		$serial
	)

	$headers = makeHeaders -token
	
	$ProgressPreference = 'SilentlyContinue'
	$device = Invoke-WebRequest -Uri "$apiUrl/devices" -Headers $headers -Method Get
	$ProgressPreference = 'Continue'
	
	$device = $device.Content
	$device = $device | ConvertFrom-Json -Depth 100
	$device = $device | Where-Object { $_.serial_number -eq $serial}

	return $device
}

function updateDevice {
	param (
		$token,
		$serial
	)

	$headers = makeHeaders -$token

	$device = getDevice -serial $serial

	$body = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
	$body.Add("blueprint_id", $newBlueprint)

	$body = $body | ConvertTo-Json

	Invoke-WebRequest -Uri "$apiUrl/devices/$($device.device_id)" -Method Patch -Headers $headers -Body $body
	
	Invoke-WebRequest -Uri "$apiUrl/devices/$($device.device_id)/action/blankpush" -Method Post -Headers $headers
	
}