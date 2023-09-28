function compareDockerFiles {
	param(
		$currentData,
		$defaultData
	)

	if ($currentRoot -ne $defaultData) {
		return $false
	}	

	return $true
}