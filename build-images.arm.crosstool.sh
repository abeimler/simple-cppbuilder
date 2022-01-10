#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.crosstool-ng \
    --build-arg vcpkg_target_triplet="arm-linux" \
    --build-arg cross_triple="arm-unknown-linux-gnueabi" \
    --build-arg cmake_toolchain_file="/home/cmake/arm-toolchain.cmake" \
    -t abeimler/simple-cppbuilder:arm-unknown-linux-gnueabi .
    
#docker build --force-rm=true -f ./Dockerfile.crosstool-ng \
#    --build-arg vcpkg_target_triplet="avr" \
#    --build-arg cross_triple="avr" \
#    --build-arg cmake_toolchain_file="/home/cmake/avr-toolchain.cmake" \
#    -t abeimler/simple-cppbuilder:avr .

#docker build --force-rm=true -f ./Dockerfile.crosstool-ng \
#    --build-arg vcpkg_target_triplet="ppc64le-linux" \
#    --build-arg cross_triple="powerpc64le-unknown-linux-gnu" \
#    --build-arg cmake_toolchain_file="/home/cmake/ppc64le-toolchain.cmake" \
#    -t abeimler/simple-cppbuilder:powerpc64le-unknown-linux-gnu .