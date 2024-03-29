#!/bin/bash

set -euo pipefail

"${CROSS_CMAKE}" \
    -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${CHAINLOAD_TOOLCHAIN_FILE}" \
    -DVCPKG_TARGET_TRIPLET="${TARGET_TRIPLET}" \
    ${CMAKE_ARGS}

# @FIXME: "CMake Error: Unknown argument --build" with ${CROSS_CMAKE} ... use ninja, ${CROSS_MAKE} = ninja
#cmake -B build --build build --target "${TARGET}"
cd build || exit
"${CROSS_MAKE}" "${TARGET}"
