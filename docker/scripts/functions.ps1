function compareDockerFiles {
	param(
		$currentData,
		$defaultData
	)

	if (-not (Get-Content -Path $dockerFile | Test-Json)) { return $false }

	return ($currentData.allowedOrgs -eq $defaultData)
}