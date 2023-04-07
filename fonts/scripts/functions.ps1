$missingFonts = [System.Collections.ArrayList]::new()

function checkForFonts {
	param()
	foreach ($font in $fonts) {
		$fontNotFound = $true
		foreach ($library in $libraries) {
			if (Test-Path -Path "$library/$font" -PathType Leaf) {
				$fontNotFound = $false
				break
			}
		}
		if ($fontNotFound) {
			$missingFonts.Add($font)
		}
	}

	if ($missingFonts.Count -gt 0) {
		return $missingFonts
	}

	return $null
}