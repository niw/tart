#!/bin/sh

# helper script to build a signed tart.app bundle
# usage: ./scripts/build-app.sh [debug|release]

set -e

CONFIGURATION="${1:-debug}"

swift build --product tart --configuration "$CONFIGURATION"

rm -Rf .build/tart.app/
mkdir -p .build/tart.app/Contents/MacOS .build/tart.app/Contents/Resources
cp -c ".build/$CONFIGURATION/tart" .build/tart.app/Contents/MacOS/tart
cp -c Resources/embedded.provisionprofile .build/tart.app/Contents/embedded.provisionprofile
cp -c Resources/Info.plist .build/tart.app/Contents/Info.plist
cp -c "Resources/actool/UPW Tart.icns" "Resources/actool/Assets.car" .build/tart.app/Contents/Resources/

codesign --sign - --entitlements Resources/tart-dev.entitlements --force .build/tart.app
