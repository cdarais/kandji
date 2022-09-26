#!/bin/zsh

apps=()

directoryExclusions=(
    "\/Library\/Image Capture.*"
    "\/System\/Applications.*"
    "\/System\/Library\/CoreServices.*"
    "\/System\/Library\/Frameworks.*"
    "\/System\/Library\/Image Capture.*"
    "\/System\/Library\/Input Methods.*"
    "\/System\/Library\/PrivateFrameworks.*"
    "\/System\/Library\/Templates.*"
    "\/System\/Volumes\/Data.*"
    "\.app.{1,}"
)

appExclusions=(
    "/Library/Application Support/Kandji/Kandji Menu/Kandji Menu.app"
    "/Library/Application Support/Malwarebytes/Malwarebytes Endpoint Agent/EndpointAgentDaemon.app"
    "/Library/Application Support/Malwarebytes/Malwarebytes Endpoint Agent/UserAgent.app"
    "/Library/Application Support/Script Editor/Templates/Cocoa-AppleScript Applet.app"
    "/Library/Application Support/Script Editor/Templates/Droplets/Droplet with Settable Properties.app"
    "/Library/Application Support/Script Editor/Templates/Droplets/Recursive File Processing Droplet.app"
    "/Library/Application Support/Script Editor/Templates/Droplets/Recursive Image File Processing Droplet.app"
    "/Library/Developer/CommandLineTools/Library/Frameworks/Python3.framework/Versions/3.8/Resources/Python.app"
    "/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Resources/GoogleSoftwareUpdateAgent.app"
    "/Library/Google/GoogleSoftwareUpdate/GoogleSoftwareUpdate.bundle/Contents/Helpers/GoogleSoftwareUpdateAgent.app"
    "/Library/Kandji/Kandji Agent.app"
    "/usr/libexec/MiniTerm.app"
    "/System/Library/ColorSync/Calibrators/Display Calibrator.app"
    "/System/Library/Classroom/ClassroomStudentMenuExtra.app"
    "/System/Library/Filesystems/AppleShare/check_afp.app"
    "/System/Library/Filesystems/webdav.fs/Contents/Resources/webdav_cert_ui.app"
    "/System/Library/PreferencePanes/Displays.prefPane/Contents/Resources/MirrorDisplays.app"
    "/System/Library/Services/ChineseTextConverterService.app"
    "/System/Library/Services/SummaryService.app"
)

remove=(
    ".Microsoft Excel.app"
    ".Microsoft Word.app"
    "1Password 7.app"
    # "Anaconda.app"
    "Electric.app"
    "GarageBand.app"
    # "iMovie.app"
    "Keynote.app"
    "Magnet.app"
    "Microsoft Excel.app.installBackup"
    "Microsoft Word.app.installBackup"
    "Numbers.app"
    # "Notion.app"
    "Pages.app"
)

while IFS= read -r -d $'\0'; do
    total=0
    for d in $directoryExclusions; do
        addition=$(grep -cE $d <<< $REPLY)
        total=$((total+addition))
    done

    for a in $appExclusions; do
        addition=$(grep -c $a <<< $REPLY)
        total=$((total+addition))
    done

    if [[ $total == 0 ]]; then
        apps+=("$REPLY")
    fi
done < <(find / -iname "*\.app" -print0 2>/dev/null)

for a in "${apps[@]}"; do
    for r in "${remove[@]}"; do
        if [[ $a =~ $r ]]; then
            sudo rm -rf $a
        fi
    done
done