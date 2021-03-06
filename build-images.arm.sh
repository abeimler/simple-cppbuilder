#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg vcpkg_target_triplet="arm64-linux" \
    --build-arg cross_triple="aarch64-linux-gnu" \
    --build-arg install_toolchain="aarch64-linux-gnu-gcc" \
    --build-arg cmake_generator="Ninja" \
    --build-arg make="ninja" \
    --build-arg cmake="cmake" \
    --build-arg cross_make="ninja" \
    --build-arg cross_cmake="cmake" \
    --build-arg cmake_toolchain_file="/home/cmake/aarch64-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:aarch64-linux .


## @FIXME: https://aur.archlinux.org/packages/arm-linux-gnueabihf-gcc-stage1/#pinned-806072
#docker build --force-rm=true -f ./Dockerfile.cross \
#    --build-arg vcpkg_target_triplet="arm-linux" \
#    --build-arg cross_triple="arm-linux-gnueabihf" \
#    --build-arg install_toolchain="arm-linux-gnueabihf-gcc-stage1 arm-linux-gnueabihf-gcc-stage2 arm-linux-gnueabihf-gcc" \
#    --build-arg cmake_generator="Ninja" \
#    --build-arg make="ninja" \
#    --build-arg cmake="cmake" \
#    --build-arg cmake_toolchain_file="/home/cmake/arm-toolchain.cmake" \
#    -t abeimler/simple-cppbuilder:arm-linux-gnueabihf .