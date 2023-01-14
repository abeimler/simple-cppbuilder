#!/bin/bash

set -euo pipefail

"${CMAKE}" -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" ${CMAKE_ARGS}

"${CMAKE}" --build build --target "${TARGET}"

ctest --build-test --test-dir build

# Create lcov report
lcov --capture --directory build --output-file build/coverage.info
lcov --remove build/coverage.info '/usr/*' --output-file build/coverage.info # filter system-files
#lcov --list build/coverage.info # debug info
