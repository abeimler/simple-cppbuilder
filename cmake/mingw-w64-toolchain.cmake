cmake_minimum_required(VERSION 3.15)

# src: https://aur.archlinux.org/cgit/aur.git/tree/toolchain-mingw.cmake?h=mingw-w64-cmake

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR $ENV{PROCESSOR})

#set(CMAKE_SYSROOT $ENV{CROSS_ROOT})
set(CMAKE_FIND_ROOT_PATH $ENV{CROSS_ROOT})

set(CMAKE_C_COMPILER $ENV{CROSS_TRIPLET}-gcc)
set(CMAKE_CXX_COMPILER $ENV{CROSS_TRIPLET}-g++)
# set the resource compiler (RHBZ #652435)
set(CMAKE_RC_COMPILER $ENV{CROSS_TRIPLET}-windres)
set(CMAKE_MC_COMPILER $ENV{CROSS_TRIPLET}-windmc)

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Make sure Qt can be detected by CMake
set(QT_BINARY_DIR /usr/$ENV{CROSS_TRIPLET}/bin /usr/bin)
set(QT_INCLUDE_DIRS_NO_SYSTEM ON)
set(QT_HOST_PATH "/usr" CACHE PATH "host path for Qt")


# override boost thread component suffix as mingw-w64-boost is compiled with threadapi=win32
set(Boost_THREADAPI win32)

# These are needed for compiling lapack (RHBZ #753906)
set(CMAKE_Fortran_COMPILER $ENV{CROSS_TRIPLET}-gfortran)
set(CMAKE_AR:FILEPATH $ENV{CROSS_TRIPLET}-ar)
set(CMAKE_RANLIB:FILEPATH $ENV{CROSS_TRIPLET}-ranlib)
