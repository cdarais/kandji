#!/bin/zsh 
#post install

#variables
installer="Camtasia.dmg"
base="/var/tmp"

#mount
sudo hdiutil attach "$base/$installer"

#install
sudo cp -R "/Volumes/Camtasia/Camtasia 2021.app" "/Applications"

#unmount
sudo hdiutil unmount "/Volumes/Camtasia"

#clean up
/bin/rm -Rf "$base/$installer"

exit 0