function checkXcode{
	param (
		$version
	)
	$installedVersion = xcode-select -v

	if ($installedVersion -eq "xcode-select version $version." ) {
		return $true
	}

	return $false
}