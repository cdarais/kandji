#!/bin/zsh

source $1/variables.zsh
source $1/functions.zsh

Write-Host "fixing local dictionary"

currentDictionary=()

while IFS= read -r line
do
	$currentDictionary+=$line
done < /Users/$currentUser/Library/Spelling/LocalDictionary

Out-File -FilePath $sudoersFile
$defaultSudoersData | Out-File -FilePath $sudoersFile -Append

Invoke-Expression "$($args[0])/Audit-SudoersFile.ps1 $($args[0])"