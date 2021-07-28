#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg vcpkg_target_triplet=arm-android \
    --build-arg android_abi=armeabi-v7a \
    -t abeimler/simple-cppbuilder:arm-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg vcpkg_target_triplet=arm64-android \
    --build-arg android_abi=arm64-v8a \
    -t abeimler/simple-cppbuilder:arm64-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg vcpkg_target_triplet=x86-android \
    --build-arg android_abi=x86 \
    -t abeimler/simple-cppbuilder:x86-android .

docker build --force-rm=true -f ./Dockerfile.android \
    --build-arg vcpkg_target_triplet=x64-android \
    --build-arg android_abi=x86_64 \
    -t abeimler/simple-cppbuilder:x64-android .
