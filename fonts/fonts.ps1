$uri = "https://raw.githubusercontent.com/cdarais/kandji/main/fonts"

$fonts = @(
	"Inter-Black.otf",
	"Inter-Black.ttf",
	"Inter-BlackItalic.otf",
	"Inter-Bold.otf",
	"Inter-Bold.ttf",
	"Inter-BoldItalic.otf",
	"Inter-ExtraBold.otf",
	"Inter-ExtraBold.ttf",
	"Inter-ExtraBoldItalic.otf",
	"Inter-ExtraLight.otf",
	"Inter-ExtraLight.ttf",
	"Inter-ExtraLightItalic.otf",
	"Inter-Italic.otf",
	"Inter-Light.otf",
	"Inter-Light.ttf",
	"Inter-LightItalic.otf",
	"Inter-Medium.otf",
	"Inter-Medium.ttf",
	"Inter-MediumItalic.otf",
	"Inter-Regular.otf",
	"Inter-Regular.ttf",
	"Inter-SemiBold.otf",
	"Inter-SemiBold.ttf",
	"Inter-SemiBoldItalic.otf",
	"Inter-Thin.otf",
	"Inter-Thin.ttf",
	"Inter-ThinItalic.otf",
	"Inter-V.ttf",
	"Lato-Black.ttf",
	"Lato-BlackItalic.ttf",
	"Lato-Bold.ttf",
	"Lato-BoldItalic.ttf",
	"Lato-Hairline.ttf",
	"Lato-HairlineItalic.ttf",
	"Lato-Heavy.ttf",
	"Lato-HeavyItalic.ttf",
	"Lato-Italic.ttf",
	"Lato-Light.ttf",
	"Lato-LightItalic.ttf",
	"Lato-Medium.ttf",
	"Lato-MediumItalic.ttf",
	"Lato-Regular.ttf",
	"Lato-Semibold.ttf",
	"Lato-SemiboldItalic.ttf",
	"Lato-Thin.ttf",
	"Lato-ThinItalic.ttf",
	"PlayfairDisplay-Black.tff",
	"PlayfairDisplay-BlackItalic.tff",
	"PlayfairDisplay-Bold.tff",
	"PlayfairDisplay-BoldItalic.tff",
	"PlayfairDisplay-ExtraBold.tff",
	"PlayfairDisplay-ExtraBoldItalic.tff",
	"PlayfairDisplay-Italic.tff",
	"PlayfairDisplay-Medium.tff",
	"PlayfairDisplay-MediumItalic.tff",
	"PlayfairDisplay-Regular.tff",
	"PlayfairDisplay-SemiBold.tff",
	"PlayfairDisplay-SemiBoldItalic.tff"
)


$libraries = @(
	"/Library/Fonts",
	"~/Library/Fonts",
	"/System/Library/Fonts",
	"/System/Library/Font/Supplemental"
)

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
	Write-Host "installing"
	foreach ($missingFont in $missingFonts) {
		Write-Host "$missingFont"
		Invoke-WebRequest -Uri "$uri/data/$missingFont" -OutFile "$($libraries[0])/$missingFont"
	}
} else {
	Write-Host "no missing fonts detected"
	exit 0
}

$missingFonts = [System.Collections.ArrayList]::new()

if (checkForFonts) {
	Write-Host "missing fonts $missingFonts"
	exit 1
}

exit 0