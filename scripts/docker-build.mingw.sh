#!/bin/bash

# src: https://aur.archlinux.org/cgit/aur.git/tree/mingw-env.sh?h=mingw-w64-environment

default_mingw_pp_flags="-D_FORTIFY_SOURCE=2 -D_GLIBCXX_ASSERTIONS"
default_mingw_compiler_flags="$default_mingw_pp_flags -O2 -pipe -fno-plt -fexceptions --param=ssp-buffer-size=4 -Wformat -Werror=format-security -fcf-protection"
default_mingw_linker_flags="-Wl,-O1,--sort-common,--as-needed -fstack-protector"

export CPPFLAGS="${MINGW_CPPFLAGS:-$default_mingw_pp_flags $CPPFLAGS}"
export CFLAGS="${MINGW_CFLAGS:-$default_mingw_compiler_flags $CFLAGS}"
export CXXFLAGS="${MINGW_CXXFLAGS:-$default_mingw_compiler_flags $CXXFLAGS}"
export LDFLAGS="${MINGW_LDFLAGS:-$default_mingw_linker_flags $LDFLAGS}"

#export PKG_CONFIG_SYSROOT_DIR="${CROSS_ROOT}"
#export PKG_CONFIG_LIBDIR="${CROSS_ROOT}/lib/pkgconfig:${CROSS_ROOT}/share/pkgconfig"

set -euo pipefail

# src: https://aur.archlinux.org/cgit/aur.git/tree/mingw-cmake.sh?h=mingw-w64-cmake

${CMAKE} \
    -B build -S . -G "${CMAKE_GENERATOR}" -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" -DCMAKE_TOOLCHAIN_FILE="${TOOLCHAIN_FILE}" \
    -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE="${CHAINLOAD_TOOLCHAIN_FILE}" \
    -DVCPKG_TARGET_TRIPLET="${TARGET_TRIPLET}" \
    ${CMAKE_ARGS}
    #-DCMAKE_INSTALL_PREFIX:PATH=${CROSS_ROOT} \
    #-DCMAKE_INSTALL_LIBDIR:PATH=lib \
    #-DCMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${CROSS_ROOT}/include \
    #-DCMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES:PATH=${CROSS_ROOT}/include \
    #-DBUILD_SHARED_LIBS:BOOL=ON \
    #-DCMAKE_CROSSCOMPILING_EMULATOR=/usr/bin/${CROSS_TRIPLET}-wine \

# @FIXME: "CMake Error: Unknown argument --build" with ${CROSS_CMAKE} ... use ninja, ${CROSS_MAKE} = ninja
#cmake -B build --build build --target "${TARGET}"
cd build && ${CROSS_MAKE} "${TARGET}"