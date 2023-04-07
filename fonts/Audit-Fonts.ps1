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
	Write-Host "missing font count: $($missingFonts.Count)"
	New-Item -Path "$($args[0])/1" -ItemType File | Out-Null
} else {
	Write-Host "no missing fonts detected"
}