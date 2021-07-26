#!/bin/bash

cmake -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="/usr/lib/emscripten/cmake/Modules/Platform/Emscripten.cmake" \
    -DVCPKG_TARGET_TRIPLET="${TARGET_TRIPLET}" \
    ${CMAKE_ARGS}

cmake --build build --target "${TARGET}"