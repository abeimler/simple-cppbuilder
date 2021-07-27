#!/bin/bash

cmake -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" ${CMAKE_ARGS}
cmake --build build --target "${TARGET}"

ctest --build-test --test-dir build