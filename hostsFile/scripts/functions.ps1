function compareHostsData {
	param(
		$currentData,
		$defaultData
	)

	if ($currentData.Count -ne $defaultData.Count) {
		return $false
	}

	for ($i = 0; $i -lt $currentData.Count; $i++) {
		if ($currentData[$i] -ne $defaultData[$i]) {
			return $false
		}
	}

	return $true
}