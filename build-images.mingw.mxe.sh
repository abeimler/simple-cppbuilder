#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.mxe \
    --build-arg vcpkg_target_triplet="x64-mingw-dynamic" \
    --build-arg cross_triplet="x86_64-w64-mingw32.shared" \
    --build-arg processor="x86_64" \
    -t abeimler/simple-cppbuilder:x64-mingw-w64-mxe .

docker build --force-rm=true -f ./Dockerfile.mxe \
    --build-arg vcpkg_target_triplet="x86-mingw-dynamic" \
    --build-arg cross_triplet="i686-w64-mingw32.shared" \
    --build-arg processor="i686" \
    -t abeimler/simple-cppbuilder:x86-mingw-w64-mxe .


docker build --force-rm=true -f ./Dockerfile.mxe \
    --build-arg vcpkg_target_triplet="x64-mingw-static" \
    --build-arg cross_triplet="x86_64-w64-mingw32.static" \
    --build-arg processor="x86_64" \
    -t abeimler/simple-cppbuilder:x64-mingw-w64-mxe-static .

docker build --force-rm=true -f ./Dockerfile.mxe \
    --build-arg vcpkg_target_triplet="x86-mingw-static" \
    --build-arg cross_triplet="i686-w64-mingw32.static" \
    --build-arg processor="i686" \
    -t abeimler/simple-cppbuilder:x86-mingw-w64-mxe-static .


