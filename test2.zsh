
declare -a fonts 

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
    if [[ -f "$f" ]]; then
        echo "$f exists"
    fi
done