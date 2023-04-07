. "$($args[0])/variables.ps1"

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
	return $fontNotFound
}

if (checkForFonts) {
	Write-Host "missing font count: $($missingFonts.count)"
	return 1
}

Write-Host "no missing fonts detected"
return 0