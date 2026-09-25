#!/bin/bash
# Упаковывает macos/BochaSwitcher.app (собранный build_app.sh) в DMG с ярлыком «Программы».
# Использование: bash macos/make_dmg.sh [папка-назначения]
# Печатает путь к готовому BochaSwitcher-<версия>.dmg последней строкой.
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_NAME="BochaSwitcher"
APP="$PROJECT_DIR/$APP_NAME.app"
OUT_DIR="${1:-$PROJECT_DIR}"

if [ ! -d "$APP" ]; then
    echo "ERROR: $APP not found — run build_app.sh first" >&2
    exit 1
fi

VERSION=$(/usr/libexec/PlistBuddy -c 'Print :CFBundleShortVersionString' "$APP/Contents/Info.plist")
DMG="$OUT_DIR/$APP_NAME-$VERSION.dmg"

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
ditto "$APP" "$STAGE/$APP_NAME.app"
ln -s /Applications "$STAGE/Applications"

rm -f "$DMG"
hdiutil create -volname "Bocha Switcher" -srcfolder "$STAGE" -format UDZO -ov "$DMG" >/dev/null
echo "$DMG"
