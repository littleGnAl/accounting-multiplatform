#!/bin/bash
cd android
gradle_wrapper_version=$(./gradlew -q getGradleWrapperVersion | tail -n 1)
echo "gradle wrapper version: $gradle_wrapper_version"

rm -rf ~/.gradle/caches/${gradle_wrapper_version}/
rm -rf ~/.gradle/caches/transforms-1
rm -rf ~/.gradle/caches/transforms-2
rm -rf ~/.gradle/caches/journal-1
find ~/.gradle/caches/ -name "*.lock" -type f -delete