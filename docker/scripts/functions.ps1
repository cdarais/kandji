function compareDockerFiles {
	param(
		$currentData,
		$defaultData
	)

	return ( $currentData.allowedOrgs -eq $defaultData.allowedOrgs )
}