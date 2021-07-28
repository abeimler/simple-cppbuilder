#!/bin/bash

cmake -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" ${CMAKE_ARGS}

cmake --build build --target "${TARGET}"