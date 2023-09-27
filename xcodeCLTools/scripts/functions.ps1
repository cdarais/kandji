function checkXcode{
	param (
		$version
	)
	$installedVersion = pkgutil --pkg-info com.apple.pkg.CLTools_Executables | awk '/version: / {print $NF }' | cut -d. -f-2

	if ($installedVersion -gt $version ) {
		return $true
	}

	return $false
}