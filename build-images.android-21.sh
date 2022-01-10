#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.android-21 \
    --build-arg vcpkg_target_triplet="arm-android" \
    --build-arg cmake="android-armv7a-eabi-cmake" \
    --build-arg android_abi="armeabi-v7a" \
    -t abeimler/simple-cppbuilder:arm-android-21 .

docker build --force-rm=true -f ./Dockerfile.android-21 \
    --build-arg vcpkg_target_triplet="arm64-android" \
    --build-arg cmake="android-aarch64-cmake" \
    --build-arg android_abi="arm64-v8a" \
    -t abeimler/simple-cppbuilder:arm64-android21 .

docker build --force-rm=true -f ./Dockerfile.android-21 \
    --build-arg vcpkg_target_triplet="x86-android" \
    --build-arg cmake="android-x86-cmake" \
    --build-arg android_abi="x86" \
    -t abeimler/simple-cppbuilder:x86-android-21 .

docker build --force-rm=true -f ./Dockerfile.android-21 \
    --build-arg vcpkg_target_triplet="x64-android" \
    --build-arg cmake="android-x86-64-cmake" \
    --build-arg android_abi="x86_64" \
    -t abeimler/simple-cppbuilder:x64-android-21 .