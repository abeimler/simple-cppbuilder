cmake_minimum_required(VERSION 3.15)

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_SYSROOT /home/crosstool-ng/x-tools$ENV{CT_TARGET_ALIAS}/sysroot)
set(CMAKE_STAGING_PREFIX /home/stage)

set(tools /home/crosstool-ng/x-tools$ENV{CT_TARGET_ALIAS})
set(CMAKE_C_COMPILER ${tools}/bin/arm-rpi-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER ${tools}/bin/arm-rpi-linux-gnueabihf-g++)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)