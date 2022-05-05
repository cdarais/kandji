
declare -a fonts 

library1="/Library/Fonts"
library2="/System/Library/Fonts"
library3="$library2/Supplemental"
library4="~/$library1"

fonts=(
    "Inter-Black.otf"
    "Inter-ExtraBold.otf"
    "Inter-Italic.otf"
    "Inter-MediumItalic.otf"
    "Inter-Thin.otf"
    "Inter-BlackItalic.otf"
    "Inter-ExtraBoldItalic.otf"
    "Inter-Light.otf"
    "Inter-Regular.otf"
    "Inter-ThinItalic.otf"
    "Inter-Bold.otf"
    "Inter-ExtraLight.otf"
    "Inter-LightItalic.otf"
    "Inter-SemiBold.otf"
    "Inter-V.ttf"
    "Inter-BoldItalic.otf"
    "Inter-ExtraLightItalic.otf"
    "Inter-Medium.otf"
    "Inter-SemiBoldItalic.otf"
)

for f in "${fonts[@]}"; do
    if [[ ! -f "$library1/$f" && ! -f "$library2/$f" && ! -f "$library3/$f" && ! -f "$library4/$f" ]]; then
        echo "$f not found"
    fi
done