#!/bin/zsh
declare -a fonts

urlBase="https://raw.githubusercontent.com/cdarais/kandji/main/fonts"
library1="/Library/Fonts"
library2="/System/Library/Fonts"
library3="$library2/Supplemental"
library4="~/$library1"

fonts=(
    "Inter-Black.otf"
    "Inter-Black.ttf"
    "Inter-BlackItalic.otf"
    "Inter-Bold.otf"
    "Inter-Bold.ttf"
    "Inter-BoldItalic.otf"
    "Inter-ExtraBold.otf"
    "Inter-ExtraBold.ttf"
    "Inter-ExtraBoldItalic.otf"
    "Inter-ExtraLight.otf"
    "Inter-ExtraLight.ttf"
    "Inter-ExtraLightItalic.otf"
    "Inter-Italic.otf"
    "Inter-Light.otf"
    "Inter-Light.ttf"
    "Inter-LightItalic.otf"
    "Inter-Medium.otf"
    "Inter-Medium.ttf"
    "Inter-MediumItalic.otf"
    "Inter-Regular.otf"
    "Inter-Regular.ttf"
    "Inter-SemiBold.otf"
    "Inter-SemiBold.ttf"
    "Inter-SemiBoldItalic.otf"
    "Inter-Thin.otf"
    "Inter-Thin.ttf"
    "Inter-ThinItalic.otf"
    "Inter-V.ttf"
    "Lato-Black.ttf"
    "Lato-BlackItalic.ttf"
    "Lato-Bold.ttf"
    "Lato-BoldItalic.ttf"
    "Lato-Hairline.ttf"
    "Lato-HairlineItalic.ttf"
    "Lato-Heavy.ttf"
    "Lato-HeavyItalic.ttf"
    "Lato-Italic.ttf"
    "Lato-Light.ttf"
    "Lato-LightItalic.ttf"
    "Lato-Medium.ttf"
    "Lato-MediumItalic.ttf"
    "Lato-Regular.ttf"
    "Lato-Semibold.ttf"
    "Lato-SemiboldItalic.ttf"
    "Lato-Thin.ttf"
    "Lato-ThinItalic.ttf"
    "PlayfairDisplay-Black.tff"
    "PlayfairDisplay-BlackItalic.tff"
    "PlayfairDisplay-Bold.tff"
    "PlayfairDisplay-BoldItalic.tff"
    "PlayfairDisplay-ExtraBold.tff"
    "PlayfairDisplay-ExtraBoldItalic.tff"
    "PlayfairDisplay-Italic.tff"
    "PlayfairDisplay-Medium.tff"
    "PlayfairDisplay-MediumItalic.tff"
    "PlayfairDisplay-Regular.tff"
    "PlayfairDisplay-SemiBold.tff"
    "PlayfairDisplay-SemiBoldItalic.tff"
)

for f in "${fonts[@]}"; do

    if [[ ! -f "$library1/$f" && ! -f "$library2/$f" && ! -f "$library3/$f" && ! -f "$library4/$f" ]]
    then
        echo "$f not found"
        echo "$urlBase/data/$f"
        curl -s "$urlBase/data/$f" -o "$library1/$f"
    else
        echo "$f found"
    fi

    if [[ ! -f "$library1/$f" && ! -f "$library2/$f" && ! -f "$library3/$f" && ! -f "$library4/$f" ]]
    then
        exit 1
    else
        echo "$f found"
    fi
done


exit 0