function checkForFonts {
	param (
		$FontsToCheck
	)

	$missingFonts = [System.Collections.ArrayList]::new()

	foreach ($font in $FontsToCheck) {
		
		if ( -not ($libraries | Where-Object { Test-Path -Path "$_/$font" -PathType Leaf }) ) {
			$missingFonts.Add($font)
		}
	}

	return $missingFonts
}