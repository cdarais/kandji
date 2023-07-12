. "$($args[0])/variables.ps1"

foreach ($s in $systemSettings) {
	/usr/bin/security $s.file $s.readWrite $s.pane $s.blockAllow
}
