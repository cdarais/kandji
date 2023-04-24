. "$($args[0])/functions.ps1"
. "$($args[0])/variables.ps1"


Write-Host "attempting to resolve discrepencies"

chmod +x $args[0]/$installScript

zsh -c "$($args[0])/streamer/$installScript -i $($args[0])/streamer/$installFile -d $streamCode -w 0 -s 0 -v 0"

/bin/rm -rf "$($args[0])/streamer"

Invoke-Expression "$($args[0])/Audit-SplashtopStreamer.ps1 $($args[0])"