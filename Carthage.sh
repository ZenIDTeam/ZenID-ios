carthage update --platform ios

for D in ./Carthage/Checkouts/*; do
  if [ -d "${D}" ]; then
    find $D -type d -name \*.xcodeproj -print0 |
      while IFS= read -r -d $'\0' folder; do
        sed -i '' 's/ENABLE_BITCODE = NO;//g' $folder/project.pbxproj
      done
    fi
done

carthage build --no-use-binaries --use-xcframeworks --platform ios
