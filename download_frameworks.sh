#!/usr/bin/env bash
#
# Downloads the ZenID SDK xcframeworks into ./Libraries for manual
# (non-SwiftPM) integration — copying the xcframeworks into your own project
# by hand.
#
# SwiftPM consumers do NOT need this script — including the bundled ZenIDSample
# app, which links the SDK via the local Swift package. Xcode resolves the
# package and downloads the frameworks automatically from the binaryTarget
# url + checksum in Package.swift.
#
# The frameworks are distributed as GitHub release archives, not committed to
# this repository.
#
set -euo pipefail

cd "$(dirname "$0")"
MANIFEST="Package.swift"

if [ ! -f "$MANIFEST" ]; then
  echo "ERROR: $MANIFEST not found next to this script." >&2
  exit 1
fi

mkdir -p Libraries

for fw in ZenID AzureAIVisionFaceUI; do
  archive="$fw.xcframework.zip"

  # The url and checksum live on the binaryTarget line referencing this archive.
  line=$(grep -F "$archive" "$MANIFEST" || true)
  url=$(printf '%s\n' "$line" | grep -oE 'https://[^"]+' | head -n1 || true)
  checksum=$(printf '%s\n' "$line" | grep -oE 'checksum: "[a-f0-9]+"' | head -n1 | cut -d'"' -f2 || true)

  if [ -z "$url" ] || [ -z "$checksum" ]; then
    echo "ERROR: could not find a url/checksum for $archive in $MANIFEST." >&2
    echo "       This script needs a release manifest (binaryTarget url/checksum)." >&2
    exit 1
  fi

  echo "Downloading $fw.xcframework ..."
  curl -fL --progress-bar -o "Libraries/$archive" "$url"

  actual=$(shasum -a 256 "Libraries/$archive" | cut -d' ' -f1)
  if [ "$actual" != "$checksum" ]; then
    echo "ERROR: checksum mismatch for $archive" >&2
    echo "  expected: $checksum" >&2
    echo "  actual:   $actual" >&2
    rm -f "Libraries/$archive"
    exit 1
  fi

  echo "Extracting $fw.xcframework ..."
  rm -rf "Libraries/$fw.xcframework"
  unzip -q -o "Libraries/$archive" -d Libraries
  rm -f "Libraries/$archive"
done

echo
echo "Done — ZenID.xcframework and AzureAIVisionFaceUI.xcframework are in ./Libraries."
echo "Add the framework(s) to your Xcode project with \"Embed & Sign\"."
