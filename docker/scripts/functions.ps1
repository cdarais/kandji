function compareDockerFiles {
	param(
		$currentData,
		$defaultData
	)

	if (-not ($dockerFile | Test-Json)) { return $false }

	return ($currentData.allowedOrgs -eq $defaultData)
}