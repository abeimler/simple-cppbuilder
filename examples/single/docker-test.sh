#!/bin/bash

cmake -B build -S .

cmake --build build

ctest --build-test --test-dir build