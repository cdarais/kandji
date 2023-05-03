function checkForFonts {
	param (
		$FontsToCheck
	)
	
	$missingFonts = [System.Collections.ArrayList]::new()

	foreach ($font in $fontsToCheck) {
		
		if ( -not ($libraries | Where-Object { Test-Path -Path "$_/$font" -PathType Leaf }) ) {
			$missingFonts.Add($font)
		}
	}

	return $missingFonts
}