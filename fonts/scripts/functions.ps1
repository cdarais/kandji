function checkForFonts {
	param (
		[Parameter(
			Position = 0
		)][System.Collections.ArrayList]$Fonts,
		[Parameter(
			Position =1
		)][System.Collections.ArrayList]$Libraries
	)

	$missingFonts = [System.Collections.ArrayList]::new()

	foreach ($font in $Fonts) {
		if ( -not ($libraries | Where-Object { Test-Path -Path "$_/$font" -PathType Leaf }) ) {
			$missingFonts.Add($font)
		}
	}

	return $missingFonts
}

# function checkFont {
# 	[CmdletBinding()]
# 	param (
# 		[Parameter(
# 			Position = 0
# 		)][string]$Font,
# 		[Parameter(
# 			Position =1
# 		)][System.Collections.ArrayList]$Libraries
# 	)
# 	return (-not ($Libraries | Where-Object { Test-Path -Path "$_/$Font" -PathType Leaf }))
# }