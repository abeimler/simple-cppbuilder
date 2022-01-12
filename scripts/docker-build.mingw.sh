#!/bin/bash

# src: https://aur.archlinux.org/cgit/aur.git/tree/mingw-cmake.sh?h=mingw-w64-cmake

${CROSS_CMAKE} \
    -DCMAKE_INSTALL_PREFIX:PATH=${CROSS_ROOT} \
    -DCMAKE_INSTALL_LIBDIR:PATH=lib \
    -DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${CROSS_ROOT}/include \
    -DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${CROSS_ROOT}/include \
    -DBUILD_SHARED_LIBS:BOOL=ON \
    -DCMAKE_CROSSCOMPILING_EMULATOR=/usr/bin/${CROSS_TRIPLET}-wine \
    -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${CHAINLOAD_TOOLCHAIN_FILE}" \
    -DVCPKG_TARGET_TRIPLET="${TARGET_TRIPLET}" \
    ${CMAKE_ARGS}

# @FIXME: "CMake Error: Unknown argument --build" with ${CROSS_CMAKE} ... use ninja, ${CROSS_MAKE} = ninja
#cmake -B build --build build --target "${TARGET}"
cd build && ${CROSS_MAKE} "${TARGET}"