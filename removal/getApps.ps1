$apps = zsh -c 'system_profiler -xml SPApplicationsDataType'

$txt = Get-Content /Users/chris.darais/test.txt -Encoding utf8

$txt = $txt -join ','
$txt = "[$txt'}]"
$txt = $txt.Replace(",      ", ";      ")
$txt = $txt.Replace(",    ", ";    ")
$txt = $txt.Replace(",", "")
$txt = $txt.Replace("Applications:;    ", '{''name'':''')
$txt = $txt.Replace(":;      Version: ",''',''version'':''')
$txt = $txt.Replace(";      Obtained from: ",''',''obtainedFrom'':''')
$txt = $txt.Replace(";      Last Modified: ",''',''lastModified'':''')
$txt = $txt.Replace(";      Kind: ",''',''kind'':''')
$txt = $txt.Replace(";      Signed by: ",''',''signedBy'':''')
$txt = $txt.Replace(";      Location: ",''',''location'':''')
$txt = $txt.Replace(';    ','''},{''name'':''')


$json = $txt | ConvertFrom-Json

$json = $json | Where-Object { $null -ne $_.location }