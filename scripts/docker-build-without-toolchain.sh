#!/bin/bash

set -euo pipefail

${CMAKE} -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" ${CMAKE_ARGS}

${CMAKE} --build build --target "${TARGET}"