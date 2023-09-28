function compareDockerFiles {
	param(
		$currentData,
		$defaultData
	)

	if ($currentData -ne $defaultData) {
		return $false
	}	

	return $true
}