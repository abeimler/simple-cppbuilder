#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg vcpkg_target_triplet="arm-linux" \
    --build-arg cross_triple="armv8-rpi4-linux-gnueabihf" \
    --build-arg cmake_toolchain_file="/home/cmake/arm-rpi-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:rpi4 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg vcpkg_target_triplet="arm-linux" \
    --build-arg cross_triple="armv8-rpi3-linux-gnueabihf" \
    --build-arg cmake_toolchain_file="/home/cmake/arm-rpi-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:rpi3 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg vcpkg_target_triplet="arm-linux" \
    --build-arg cross_triple="armv7-rpi2-linux-gnueabihf" \
    --build-arg cmake_toolchain_file="/home/cmake/arm-rpi-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:rpi2 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg vcpkg_target_triplet="arm-linux" \
    --build-arg cross_triple="armv6-unknown-linux-gnueabihf" \
    --build-arg cmake_toolchain_file="/home/cmake/arm-rpi-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:rpi1 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg vcpkg_target_triplet="arm64-linux" \
    --build-arg cross_triple="aarch64-rpi4-linux-gnu" \
    --build-arg cmake_toolchain_file="/home/cmake/aarch64-rpi-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:rpi4-aarch64 .

docker build --force-rm=true -f ./Dockerfile.rpi \
    --build-arg vcpkg_target_triplet="arm64-linux" \
    --build-arg cross_triple="aarch64-rpi3-linux-gnu" \
    --build-arg cmake_toolchain_file="/home/cmake/aarch64-rpi-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:rpi3-aarch64 .