function checkXcode{
	param (
		$version
	)
	$installedVersion = pkgutil --pkg-info com.apple.pkg.CLTools_Executables | awk '/version: / {print $NF }' | cut -d. -f-2
	Write-Host "expected to find ""$version"" and found ""$installedVersion"""
	if ([decimal]$installedVersion -ge [decimal]$version ) {
		return $true
	}

	return $false
}