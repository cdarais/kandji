$licenseKey = "MU7N5-6J4AH-HWQ2W-C555M-ZM388"
$licensePath = "/Users/Shared/TechSmith/Camtasia"
$licenseFile = "LicenseKey"
$aceInstaller = "/Applications/Camtasia 2022.app/Contents/Resources/aceinstaller"

New-Item -ItemType File -Path $licensePath -Name $licenseFile -Value $licenseKey

sudo $aceInstaller install