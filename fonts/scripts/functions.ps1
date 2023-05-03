function checkForFonts {
	param()
	$missingFonts = [System.Collections.ArrayList]::new()

	foreach ($font in $fonts) {
		
		if ( -not ($libraries | Where-Object { Test-Path -Path "$_/$font" -PathType Leaf }) ) {
			$missingFonts.Add($font)
		}
	}

	return $missingFonts
}