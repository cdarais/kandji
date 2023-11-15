# . $PSScriptRoot/functions.ps1
. $PSScriptRoot/variables.ps1

foreach ($b in $bools) {
	defaults write $plist $b.name -bool $b.bool
}

foreach ($d in $dicts) {
	defaults write $plist $d.name -dict
	foreach ($v in $dicts.values) {
		defaults write $plist $d.name -dict-add $v.key $v.value
	}
}

foreach ($a in $arrays) {
	defaults write $plist $a.name -array
	foreach ($v in $arrays.values) {
		defaults write $plist $a.name -array-add $v
	}
}

foreach ($s in $strings) {
	defaults write $plist $s.name $s.value
}