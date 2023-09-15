#!/bin/bash

CURR_VERSION=taggy-v$(awk '/^version: /{print $2}' ../packages/taggy/pubspec.yaml)

# iOS & macOS
APPLE_HEADER="release_tag_name = '$CURR_VERSION' # generated; do not edit"
sed -i.bak "1 s/.*/$APPLE_HEADER/" ../packages/flutter_taggy/ios/flutter_taggy.podspec
sed -i.bak "1 s/.*/$APPLE_HEADER/" ../packages/flutter_taggy/macos/flutter_taggy.podspec
rm ../packages/flutter_taggy/macos/*.bak ../packages/flutter_taggy/ios/*.bak

# CMake platforms (Linux, Windows, and Android)
CMAKE_HEADER="set(LibraryVersion \"$CURR_VERSION\") # generated; do not edit"
for CMAKE_PLATFORM in android linux windows
do
    sed -i.bak "1 s/.*/$CMAKE_HEADER/" ../packages/flutter_taggy/$CMAKE_PLATFORM/CMakeLists.txt
    rm ../packages/flutter_taggy/$CMAKE_PLATFORM/*.bak
done

git add ../packages/flutter_taggy/
