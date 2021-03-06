#!/bin/zsh
declare -a fonts

urlBase="https://raw.githubusercontent.com/cdarais/kandji/main/fonts"
library1="/Library/Fonts"
library2="/System/Library/Fonts"
library3="$library2/Supplemental"
library4="~/$library1"

fonts=(
    "Inter-Black.otf"
    "Inter-ExtraBoldItalic.otf"
    "Inter-Medium.otf"
    "Inter-Thin.otf"
    "Lato-Hairline.ttf"
    "Lato-MediumItalic.ttf"
    "Inter-Black.ttf"
    "Inter-ExtraLight.otf"
    "Inter-Medium.ttf"
    "Inter-Thin.ttf"
    "Lato-HairlineItalic.ttf"
    "Lato-Regular.ttf"
    "Inter-BlackItalic.otf"
    "Inter-ExtraLight.ttf"
    "Inter-MediumItalic.otf"
    "Inter-ThinItalic.otf"
    "Lato-Heavy.ttf"
    "Lato-Semibold.ttf"
    "Inter-Bold.otf"
    "Inter-ExtraLightItalic.otf"
    "Inter-Regular.otf"
    "Inter-V.ttf"
    "Lato-HeavyItalic.ttf"
    "Lato-SemiboldItalic.ttf"
    "Inter-Bold.ttf"
    "Inter-Italic.otf"
    "Inter-Regular.ttf"
    "Lato-Black.ttf"
    "Lato-Italic.ttf"
    "Lato-Thin.ttf"
    "Inter-BoldItalic.otf"
    "Inter-Light.otf"
    "Inter-SemiBold.otf"
    "Lato-BlackItalic.ttf"
    "Lato-Light.ttf"
    "Lato-ThinItalic.ttf"
    "Inter-ExtraBold.otf"
    "Inter-Light.ttf"
    "Inter-SemiBold.ttf"
    "Lato-Bold.ttf"
    "Lato-LightItalic.ttf"
    "Inter-ExtraBold.ttf"
    "Inter-LightItalic.otf"
    "Inter-SemiBoldItalic.otf"
    "Lato-BoldItalic.ttf"
    "Lato-Medium.ttf"
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