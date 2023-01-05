#!/bin/sh

. "$SETUP_ENV_SCRIPT"

"${CROSS_CMAKE}" -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${ANDROID_TOOLCHAIN_FILE}" \
    -DVCPKG_TARGET_TRIPLET="${TARGET_TRIPLET}" \
    -DANDROID_ABI="${ANDROID_ABI}" \
    ${CMAKE_ARGS}

"${CROSS_CMAKE}" --build build --target "${TARGET}"
