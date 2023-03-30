#!/bin/zsh

declare -a applications
applications=(
    "com.apple.AddressBook"
    "com.apple.AppStore"
    "com.apple.FaceTime"
    "com.apple.freeform"
    "com.apple.iCal"
    "com.apple.Maps"
    "com.apple.mail"
    "com.apple.MobileSMS"
    "com.apple.Music"
    "com.apple.news"
    "com.apple.Notes"
    "com.apple.Photos"
    "com.apple.reminders"
    "com.apple.Safari"
    "com.apple.TV"
)

for a in "${applications[@]}"; do
    sudo /usr/local/bin/kandji dock --remove $a
    sleep 2
done