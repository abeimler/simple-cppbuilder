#!/bin/bash

docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg vcpkg_target_triplet="x64-mingw-dynamic" \
    --build-arg cross_triple="x86_64-w64-mingw32" \
    --build-arg install_toolchain="mingw-w64-toolchain" \
    --build-arg install_extras_toolchain="mingw-w64-pkg-config mingw-w64-cmake mingw-w64-configure mingw-w64-make mingw-w64-environment powershell-bin" \
    --build-arg cmake_generator="Ninja" \
    --build-arg make="make" \
    --build-arg cmake="cmake" \
    --build-arg cross_make="x86_64-w64-mingw32-make" \
    --build-arg cross_cmake="x86_64-w64-mingw32-cmake" \
    --build-arg setup_env_script="mingw-env" \
    --build-arg cmake_toolchain_file="/usr/share/mingw/toolchain-x86_64-w64-mingw32.cmake" \
    --build-arg docker_build_script="docker-build.mingw.sh" \
    -t abeimler/simple-cppbuilder:x64-mingw-w64 .

docker build --force-rm=true -f ./Dockerfile.cross \
    --build-arg vcpkg_target_triplet="x86-mingw-dynamic" \
    --build-arg cross_triple="i686-w64-mingw32" \
    --build-arg install_toolchain="mingw-w64-toolchain" \
    --build-arg install_extras_toolchain="mingw-w64-pkg-config mingw-w64-cmake mingw-w64-configure mingw-w64-make mingw-w64-environment powershell-bin" \
    --build-arg cmake_generator="Ninja" \
    --build-arg make="make" \
    --build-arg cmake="cmake" \
    --build-arg cross_make="i686-w64-mingw32-make" \
    --build-arg cross_cmake="i686-w64-mingw32-cmake" \
    --build-arg setup_env_script="mingw-env" \
    --build-arg cmake_toolchain_file="/usr/share/mingw/toolchain-i686-w64-mingw32.cmake" \
    --build-arg docker_build_script="docker-build.mingw.sh" \
    -t abeimler/simple-cppbuilder:x86-mingw-w64 .

