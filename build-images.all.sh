#!/bin/bash

./build-images.sh

./build-images.mingw.sh
./build-images.emscripten.sh

./build-images.arm.sh

./build-images.android.sh
./build-images.android-21.sh

./build-images.arm.crosstool.sh
./build-images.rpi.sh

./build-images.gcc.sh
./build-images.mingw.mxe.sh