function compareRootPermissions {
	param(
		$currentData,
		$defaultData
	)

	$currentRoot = $currentData | Where-Object { $_ -like "*chris.darais*" -and $_ -notlike "#*" }
	$defaultData = $defaultData | Where-Object { $_ -like "*chris.darais*" -and $_ -notlike "#*" }
	
	if ($currentRoot -ne $defaultData) {
		return $false
	}	

	return $true
}