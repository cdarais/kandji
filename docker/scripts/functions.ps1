function compareDockerFiles {
	param(
		$currentData,
		$defaultData
	)

	if ($currentData.allowedOrgs -ne $defaultData) {
		return $false
	}	

	return $true
}