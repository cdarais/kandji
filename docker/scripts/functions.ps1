function compareDockerFiles {
	param(
		$currentData,
		$defaultData
	)

	return ( $currentData -eq $defaultData )
}